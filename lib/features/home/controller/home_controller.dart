import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:night_market/features/home/repository/account_list_repository.dart';
import 'package:night_market/features/home/repository/home_repository.dart';
import 'package:night_market/shared/models/account_model.dart';

final homeControllerProvier = Provider((ref) {
  final accountList = ref.read(accountListRepositoryProvider);
  final homeRepository = ref.read(homeRepositoryProvider);
  return HomeController(
      homeRepository: homeRepository, accountListRepository: accountList);
});

class HomeController {
  HomeController({
    required this.homeRepository,
    required this.accountListRepository,
  });

  final HomeRepository homeRepository;
  final AccountListRepository accountListRepository;

  Future getListFromFirebase() async {
    await accountListRepository.getListFromFirebase();
  }

  Future getContentFromApi() async {
    await accountListRepository.getContentFromApi();
  }

  Future getResultOfSearchFromAccounts(String query) async {
    return await accountListRepository.getListWithQueryItem(query);
  }

  Map getContent() {
    return accountListRepository.getContent();
  }

  Map<String, AccountModel> getAccountList() {
    return accountListRepository.getAccountList();
  }


  String getStatus() {
    return accountListRepository.getStatus();
  }


  void setGettingData(bool getData) {
    accountListRepository.setGettingData(getData);
  }

  bool getGettingData() {
    return accountListRepository.getGettingData();
  }

  Future<bool> loginAndGetMarket(
      String userName, String password, String region) async {
    return await homeRepository.loginAndGetMarket(userName, password, region);
  }

  Future<AccountModel> getMarket(AccountModel account) async {
    return await homeRepository.getMarket(account);
  }
}
