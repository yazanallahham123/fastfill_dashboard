import 'package:fastfilldashboard/ui/administrators/new_administrators_page.dart';
import 'package:fastfilldashboard/ui/companies_users/new_companies_users_page.dart';
import 'package:fastfilldashboard/ui/groups/new_groups_page.dart';
import 'package:fastfilldashboard/ui/refills/refills_page.dart';
import 'package:fastfilldashboard/ui/stations/new_stations_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fastfilldashboard/helper/enums.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../bloc/login/bloc.dart';
import '../../bloc/login/state.dart';
import '../../helper/app_colors.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../utils/local_data.dart';
import '../../utils/misc.dart';
import '../dashboard/dashboard_page.dart';
import '../send_notifications/send_notifications_page.dart';
import '../top_up/top_up_page.dart';
import '../transactions/transactions_page.dart';
import '../users/new_users_page.dart';

class HomePage extends StatefulWidget {
  static const route = "/home_page";
  const HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (BuildContext context) => LoginBloc(), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is ErrorLoginState)
            pushToast(state.error);
          else if (state is SuccessLoginState) {
            await setCurrentUserValue(state.loginUser.value!.userDetails!);
            await setTokenValue(state.loginUser.value!.token!);
            pushToast(translate("messages.youLoggedSuccessfully"));
            print("successful login");
          }
        },
        bloc: bloc,
        child: BlocBuilder<LoginBloc, LoginState>(
            bloc: bloc,
            builder: (context, LoginState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final LoginBloc bloc;
  final LoginState state;

  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}


_getDrawerItemPage(int index)
{
  switch (index) {
    case 0:
      return new DashboardPage();
    case 1:
      return new NewUsersPage(role: roles.User);
    case 2:
      return new NewAdministratorsPage(role: roles.Admin);
    case 3:
      return new NewCompaniesUsersPage(role: roles.CompanyUser);
    case 4:
      return new NewStationsPage();
    case 5:
      return new TransactionsPage();
    case 6:
      return new SendNotificationsPage();
    case 8:
      return new TopUpPage();
    case 9:
      return new RefillsPage();
    case 10:
      return new NewGroupsPage();
  }


}


class _BuildUIState extends State<_BuildUI> {
  int pageIndex = 0;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    _initPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            title: Text(translate("labels.welcome")),
        actions: [IconButton(onPressed: () {
          if (mounted) {
            setState(() {
              pageIndex = 5;
            });
          }
        }, icon: Icon(Icons.notifications))],),
        drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  child:
                      Container(child:
                  Column(
                      children: [
                        Image(image: ExactAssetImage("assets/logo.png"),
                        height: 100,
                        ),
                    Text(_packageInfo.buildNumber)
                  ]),
                      height: 100,
                      ),
                ),
                ListTile(
                  title: Text(translate("drawer.dashboard")),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        pageIndex = 0;
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(translate("drawer.topUp")),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        pageIndex = 8;
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(translate("drawer.users")),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        pageIndex = 1;
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(translate("drawer.administrators")),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        pageIndex = 2;
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(translate("drawer.companiesUsers")),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        pageIndex = 3;
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(translate("drawer.groups")),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        pageIndex = 10;
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(translate("drawer.stations")),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        pageIndex = 4;
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(translate("drawer.transactions")),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        pageIndex = 5;
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(translate("drawer.custom_notifications")),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        pageIndex = 6;
                        Navigator.pop(context);
                      });
                    }
                  },

                ),
                ListTile(
                  title: Text(translate("drawer.refills")),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        pageIndex = 9;
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text(translate("drawer.notifications")),
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        pageIndex = 7;
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
            ListTile(
              title: Text(translate("drawer.logout")),
              onTap: () {
                Navigator.pop(context);
                showLogoutAlertDialog(context);
              },
            )
              ],
            )
        ),
        backgroundColor: backgroundColor1,
      body: _getDrawerItemPage(pageIndex),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}


