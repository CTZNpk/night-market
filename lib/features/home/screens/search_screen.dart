import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:night_market/features/auth/screens/sign_in.dart';
import 'package:night_market/features/home/controller/home_controller.dart';
import 'package:night_market/features/home/repository/account_list_repository.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static const routeName = '/search-screen';
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String searchField = '';
  late ScrollController _controller;

  List searchResults = [];

  Future getSearchResults() async {
    searchResults = await ref
        .read(homeControllerProvier)
        .getResultOfSearchFromAccounts(searchField);
    _controller.jumpTo(0);
    setState(() {});
  }

  void updateResults() async {
    searchResults = await ref
        .read(homeControllerProvier)
        .getResultOfSearchFromAccounts(searchField);
    setState(() {});
  }

  @override
  void initState() {
    _controller = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.watch(accountListRepositoryProvider).addListener(() {
        setState(() {
          updateResults();
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    ref.watch(accountListRepositoryProvider).removeListener(() {
      setState(() {
        updateResults();
      });
    });
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            style: TextStyle(color: myTheme.colorScheme.onSurface),
            onChanged: (val) => searchField = val,
          ),
          MyButton(onPressed: getSearchResults, label: 'Search'),
          SizedBox(
            height: size.height * 0.7,
            width: size.width,
            child: ListView.builder(
              controller: _controller,
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
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
                                    searchResults[index].userName,
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
                                itemCount:
                                    searchResults[index].storeItems!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index2) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '>  ${searchResults[index].storeItems![index2].name} ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                myTheme.colorScheme.onSurface,
                                          ),
                                        ),
                                        Text(
                                          '- ${searchResults[index].storeItems![index2].cost}',
                                          style: TextStyle(
                                            color:
                                                myTheme.colorScheme.onSurface,
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
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () => ref
                            .read(accountListRepositoryProvider)
                            .removeFromAccountList(
                              searchResults[index],
                            ),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                          child: const Icon(Icons.remove),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
