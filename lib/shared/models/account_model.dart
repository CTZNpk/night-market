import 'package:night_market/shared/models/offer_model.dart';

class AccountModel {
  AccountModel({
    required this.userName,
    required this.password,
    required this.region,
    required this.updatedTime,
    this.puuid,
    this.accessToken,
    this.entitlementToken,
    this.storeItems,
  });

  factory AccountModel.fromMap(Map data) {
    List store = data['store_items'];
    List<OfferModel> offers = [];

    for (var st in store) {
      offers.add(OfferModel.fromMap(st));
    }

    return AccountModel(
      userName: data['user_name'],
      password: data['password'],
      region: data['region'],
      puuid: data['puuid'],
      accessToken: data['access_token'],
      entitlementToken: data['entitlement_token'],
      storeItems: offers,
      updatedTime: DateTime.fromMillisecondsSinceEpoch(data['updated_time']),
    );
  }

  final String userName;
  final String password;
  final String region;
  String? puuid;
  String? accessToken;
  String? entitlementToken;
  List<OfferModel>? storeItems;
  DateTime updatedTime;

  Map<String, dynamic> toMap() {
    List<Map> store = [];

    if (storeItems != null) {
      for (var item in storeItems!) {
        store.add(item.toMap());
      }
    }

    return {
      'user_name': userName,
      'password': password,
      'region': region,
      'puuid': puuid,
      'access_token': accessToken,
      'entitlement_token': entitlementToken,
      'store_items': store,
      'updated_time': updatedTime.millisecondsSinceEpoch,
    };
  }
}
