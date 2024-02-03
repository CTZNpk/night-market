import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:night_market/features/auth/controller/auth_controller.dart';
import 'package:night_market/features/auth/screens/wrapper.dart';
import 'package:night_market/features/home/controller/home_controller.dart';
import 'package:night_market/features/home/repository/account_list_repository.dart';
import 'package:night_market/features/home/screens/search_screen.dart';
import 'package:night_market/features/home/screens/valorant_sign_in.dart';
import 'package:night_market/shared/models/account_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Map<String, AccountModel> accounts = {};
  List<AccountModel> listOfAcc = [];

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      setState(() {
        if (FirebaseAuth.instance.currentUser != null) {
          ref.read(homeControllerProvier).getListFromFirebase();
        }
      });
    });

    if (FirebaseAuth.instance.currentUser != null) {
      ref.read(homeControllerProvier).getListFromFirebase();
    }
    ref.read(homeControllerProvier).getContentFromApi();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(accountListRepositoryProvider).addListener(() {
        setState(() {
          accounts = ref.read(homeControllerProvier).getAccountList();
          listOfAcc = accounts.values.toList();
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    ref.watch(accountListRepositoryProvider).removeListener(() {
      setState(() {
        accounts = ref.read(homeControllerProvier).getAccountList();
        listOfAcc = accounts.values.toList();
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return FirebaseAuth.instance.currentUser == null
        ? const Authenticate()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Accounts'),
              actions: [
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, SearchScreen.routeName),
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () =>
                      ref.read(authControllerProvider).signingOut(),
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: accounts.values.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/VALORANT_1.jpg'),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Text(
                                listOfAcc[index].userName,
                                style: TextStyle(
                                  color: myTheme.colorScheme.onSurface,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Store ',
                              style: TextStyle(
                                fontSize: 16,
                                color: myTheme.colorScheme.onSurface,
                              ),
                            ),
                            Icon(
                              Icons.store,
                              color: myTheme.colorScheme.onSurface,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 160,
                          width: size.width * 0.9,
                          child: ListView.builder(
                            itemCount: listOfAcc[index].storeItems!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index2) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '>  ${listOfAcc[index].storeItems![index2].name} ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: myTheme.colorScheme.onSurface,
                                      ),
                                    ),
                                    Text(
                                      '- ${listOfAcc[index].storeItems![index2].cost}',
                                      style: TextStyle(
                                        color: myTheme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.pushNamed(
                context,
                ValorantSignIn.routeName,
              ),
              backgroundColor: myTheme.colorScheme.primary,
              child: const Icon(Icons.add),
            ),
          );
  }
}
