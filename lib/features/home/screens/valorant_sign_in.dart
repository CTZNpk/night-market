import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:night_market/features/auth/screens/sign_in.dart';
import 'package:night_market/features/home/controller/home_controller.dart';
import 'package:night_market/shared/constants.dart';
import 'package:night_market/shared/enums/region_enum.dart';
import 'package:night_market/shared/widgets/loading.dart';
import 'package:night_market/shared/widgets/show_snackbar.dart';

class ValorantSignIn extends ConsumerStatefulWidget {
  static const routeName = '/valorant-sign-in';
  const ValorantSignIn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ValorantSignInState();
}

class _ValorantSignInState extends ConsumerState<ValorantSignIn> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String? userName;
  String? password;
  String shard = 'eu';

  List<DropdownMenuEntry> list = [];

  void storingRegionsInList() {
    for (var val in Region.values) {
      list.add(
        DropdownMenuEntry(value: val.name, label: val.name),
      );
    }
  }

  void getUserName(String val) {
    userName = val;
  }

  void getPassword(String val) {
    password = val;
  }

  Future onButtonPressed(context) async {
    setState(() {
      loading = true;
    });
    for (var i = 1520; i < 1523; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1523; i < 1533; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1533; i < 1543; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1543; i < 1573; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1573; i < 1583; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1583; i < 1613; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1613; i < 1623; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1623; i < 1653; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1653; i < 1663; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1663; i < 1693; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1693; i < 1703; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1703; i < 1733; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1733; i < 1736; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1736; i < 1746; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1746; i < 1756; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1756; i < 1786; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1786; i < 1796; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1796; i < 1826; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1826; i < 1836; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1836; i < 1866; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1866; i < 1876; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1876; i < 1906; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1906; i < 1916; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1916; i < 1946; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1946; i < 1949; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1949; i < 1959; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1959; i < 1969; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 1969; i < 1999; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 1999; i < 2009; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 2009; i < 2039; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 2039; i < 2049; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 2049; i < 2079; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 2079; i < 2089; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 2089; i < 2119; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 2119; i < 2129; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 2129; i < 2159; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 2159; i < 2161; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 2162; i < 2172; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 2172; i < 2182; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 2182; i < 2212; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 2212; i < 2222; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 2222; i < 2252; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 2252; i < 2262; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 2262; i < 2292; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 2292; i < 2302; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 2302; i < 2332; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    for (var i = 2332; i < 2342; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate512', 'eu');
          
        }
    for (var i = 2342; i < 2350; i++) {
      print('XELATE$i');
        await ref
            .read(homeControllerProvier)
            .loginAndGetMarket('XelateTurk$i', 'Xelate500', 'eu');
          
        }
    setState(() {
      loading = false;
    });
    /* if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      bool success = await ref
          .read(homeControllerProvier)
          .loginAndGetMarket(userName!, password!, shard);
      setState(() {
        loading = false;
      });
      if (success == true) {
        showSnackBar(
            context: context, content: 'Signed into $userName successfully');
      } else {
        showSnackBar(
            context: context,
            content: 'Could Not Sign into $userName try again');
      }
    } */
  }

  @override
  void initState() {
    super.initState();

    storingRegionsInList();
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Valorant Account Sign in'),
      ),
      body: loading
          ? const Loading()
          : ref.read(homeControllerProvier).getGettingData()
              ? ListView(
                  children: [
                    verticalSpace,
                    Text(
                      'Cant Sign In When Loading Market ',
                      style: TextStyle(color: myTheme.colorScheme.onSurface),
                    )
                  ],
                )
              : ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: LoginForm(
                        hintText: 'UserName',
                        getEmail: getUserName,
                        getPassword: getPassword,
                      ),
                    ),
                    verticalSpace,
                    DropdownMenu(
                      dropdownMenuEntries: list,
                      label: Text(
                        'Region',
                        style: TextStyle(color: myTheme.colorScheme.onSurface),
                      ),
                      textStyle:
                          TextStyle(color: myTheme.colorScheme.onSurface),
                      onSelected: (val) {
                        shard = val;
                      },
                    ),
                    verticalSpace,
                    verticalSpace,
                    MyButton(
                      onPressed: () => onButtonPressed(context),
                      label: 'Sign In',
                    ),
                  ],
                ),
    );
  }
}
