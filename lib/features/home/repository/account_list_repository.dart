import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:night_market/shared/models/account_model.dart';
import 'package:night_market/shared/models/offer_model.dart';


final accountListRepositoryProvider = ChangeNotifierProvider(
  (ref) => AccountListRepository(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
      ref: ref),
);

class AccountListRepository with ChangeNotifier {
  AccountListRepository(
      {required this.firestore, required this.auth, required this.ref});

  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ChangeNotifierProviderRef<dynamic> ref;

  Map<String, AccountModel> accountList = {};
  Map<String, OfferModel> content = {};
  bool gettingData = false;
  String status = '';

  Future getListFromFirebase() async {
    var docs = await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('accounts')
        .get();

    for (var doc in docs.docs) {
      var account = AccountModel.fromMap(doc.data());
      accountList[account.userName] = account;
    }
    notifyListeners();
  }



  Future getListWithQueryItem(String query) async {
    List<AccountModel> resultOfSearch = [];

    for (var item in accountList.values) {
        for (int j = 0; j < item.storeItems!.length; j++) {
          if (item.storeItems![j].name.contains(query)) {
            resultOfSearch.add(item);
            break;
          }
      }
    }

    return resultOfSearch;
  }

  Future getContentFromApi() async {
    final response = await http.get(
      Uri.parse('https://api.henrikdev.xyz/valorant/v2/store-offers'),
      headers: {
        "content-type": "application/json",
      },
    );

    Map data = jsonDecode(response.body);

    List<dynamic> guns = data['data']['offers'];


    for (var gun in guns) {
      content[gun['offer_id']] = OfferModel(
        name: gun['name'],
        cost: gun['cost'],
      );
    }
    notifyListeners();
  }

  Future removeFromAccountList(AccountModel account) async {
    accountList.removeWhere((key, value) => key == account.userName);

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('accounts')
        .doc(account.userName)
        .delete();
    notifyListeners();
  }

  void addToAccountList(AccountModel account) async {
    accountList[account.userName] = account;

    notifyListeners();

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('accounts')
        .doc(account.userName)
        .set(account.toMap());

  }

  String getStatus() {
    return status;
  }

  void setStatus(String st) {
    status = st;
    notifyListeners();
  }

  Map<String, AccountModel> getAccountList() {
    return accountList;
  }

  void setGettingData(bool data) {
    gettingData = data;
    notifyListeners();
  }

  bool getGettingData() {
    return gettingData;
  }

  Map getContent() {
    return content;
  }
}
