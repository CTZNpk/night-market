import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:night_market/features/home/repository/account_list_repository.dart';
import 'package:night_market/shared/models/account_model.dart';
import 'package:night_market/shared/models/offer_model.dart';

final homeRepositoryProvider = Provider(
  (ref) => HomeRepository(ref: ref),
);

class HomeRepository {
  HomeRepository({required this.ref});

  String authEndpoint = 'https://auth.riotgames.com/api/v1/authorization';
  ProviderRef ref;

  Future<bool> loginAndGetMarket(
      String userName, String password, String region) async {
    AccountModel account = AccountModel(
      userName: userName,
      password: password,
      region: region,
      updatedTime: DateTime.now(),
    );

    ref
        .read(accountListRepositoryProvider)
        .setStatus('Signing into ${account.userName}');
    await initiateLogin(account);
    if (account.entitlementToken == null) {
      await Future.delayed(
        const Duration(seconds: 3),
      );
      return false;
    }

    ref
        .read(accountListRepositoryProvider)
        .setStatus('Getting Market For ${account.userName}');
    await getMarket(account);

      await Future.delayed(
        const Duration(seconds: 2),
      );
    ref
        .read(accountListRepositoryProvider)
        .setStatus('Signed into ${account.userName} successfully');

    ref.read(accountListRepositoryProvider).addToAccountList(account);
    return true;
  }

  Future<void> initiateLogin(AccountModel account) async {
    final networkService = NetworkService();

    Map<String, dynamic> data = {
      'client_id': 'play-valorant-web-prod',
      'nonce': '1',
      'redirect_uri': 'https://playvalorant.com/opt_in',
      'response_type': 'token id_token',
      'scope': 'account openid',
    };
    try {
      await networkService.post(
        authEndpoint,
        body: data, // Encode your data map as JSON.
      );
      data = {
        'type': 'auth',
        'username': account.userName,
        'password': account.password,
        'remember': true,
        'language': 'en_US',
      };
      try {
        final response1 = await networkService.put(
          authEndpoint,
          body: data,
        );
        String result = response1['response']['parameters']['uri'];
        RegExp pattern = RegExp(
            r'access_token=((?:[a-zA-Z]|\d|\.|-|_)*).*id_token=((?:[a-zA-Z]|\d|\.|-|_)*).*expires_in=(\d*)');
        Match? match = pattern.firstMatch(result);
        if (match != null) {
          account.accessToken = match.group(1)!;

          var headers = {
            "content-type": "application/json",
            'Authorization': 'Bearer ${account.accessToken}',
          };

          final response2 = await http.post(
            Uri.parse('https://entitlements.auth.riotgames.com/api/token/v1'),
            headers: headers,
          );
          Map data = jsonDecode(response2.body);
          account.entitlementToken = data['entitlements_token'];
          final response3 = await http.post(
            Uri.parse('https://auth.riotgames.com/userinfo'),
            headers: headers,
          );
          data = jsonDecode(response3.body);
          account.puuid = data['sub'];
        } else {
          debugPrint('No match found.');
        }
      } catch (e) {
        print('Error LOGGGING IN BROO');
        ref
            .read(accountListRepositoryProvider)
            .setStatus('Error Logging into ${account.userName}');
      }
    } catch (e) {
      ref.read(accountListRepositoryProvider).setStatus(
          'Error Signing into ${account.userName} check internet connection or wait a while to try again');
    }
  }

  Future getMarket(AccountModel account) async {
    var headers = {
      "content-type": "application/json",
      'Authorization': 'Bearer ${account.accessToken}',
    };

    headers['X-Riot-Entitlements-JWT'] = account.entitlementToken!;
    final response = await http.get(
      Uri.parse(
          'https://pd.${account.region}.a.pvp.net/store/v2/storefront/${account.puuid}'),
      headers: headers,
    );

    Map data = jsonDecode(response.body);

    var content = ref.read(accountListRepositoryProvider).getContent();

    List offers = data['BonusStore']['BonusStoreOffers'];
    account.storeItems = [];

    for (var offerId in offers) {
      var offer = offerId['Offer'];
      OfferModel item = content[offer['OfferID']];
      Map discountCost = offerId['DiscountCosts'];
      int cost = discountCost.values.toList()[0];
      print('${item.name} -> $cost');

      account.storeItems!.add(OfferModel(name: item.name, cost: cost));
    }
  }
}

void logPrint(Object object) async {
  int defaultPrintLength = 1020;
  if (object == null || object.toString().length <= defaultPrintLength) {
    print(object);
  } else {
    String log = object.toString();
    int start = 0;
    int endIndex = defaultPrintLength;
    int logLength = log.length;
    int tmpLogLength = log.length;
    while (endIndex < logLength) {
      print(log.substring(start, endIndex));
      endIndex += defaultPrintLength;
      start += defaultPrintLength;
      tmpLogLength -= defaultPrintLength;
    }
    if (tmpLogLength > 0) {
      print(log.substring(start, logLength));
    }
  }
}

class NetworkService {
  final JsonDecoder _decoder = const JsonDecoder();
  final JsonEncoder _encoder = const JsonEncoder();

  Map<String, String> headers = {
    "content-type": "application/json",
  };
  Map<String, String> cookies = {};

  void _updateCookie(http.Response response) {
    String? allSetCookie = response.headers['set-cookie'];

    if (allSetCookie != null) {
      var setCookies = allSetCookie.split(',');

      for (var setCookie in setCookies) {
        var cookies = setCookie.split(';');

        for (var cookie in cookies) {
          _setCookie(cookie);
        }
      }

      headers['cookie'] = _generateCookieHeader();
    }
  }

  void _setCookie(String? rawCookie) {
    if (rawCookie != null) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var key = keyValue[0].trim();
        var value = keyValue[1];

        // ignore keys that aren't cookies
        if (key == 'path' || key == 'expires') return;

        cookies[key] = value;
      }
    }
  }

  String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.isNotEmpty) cookie += ";";
      cookie += key + "=" + cookies[key]!;
    }

    return cookie;
  }

  Future<dynamic> get(String url) {
    return http
        .get(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      _updateCookie(response);

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {body, encoding}) {
    return http
        .post(Uri.parse(url),
            body: _encoder.convert(body), headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      _updateCookie(response);

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> put(String url, {body, encoding}) {
    return http
        .put(Uri.parse(url),
            body: _encoder.convert(body), headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      _updateCookie(response);

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
}
