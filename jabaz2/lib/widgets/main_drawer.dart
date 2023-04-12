import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:jabaz2/constants/colors.dart';
import 'package:jabaz2/models/user.dart';
import 'package:jabaz2/pages/booking_history.dart';
import 'package:jabaz2/pages/help.dart';
import 'package:jabaz2/pages/login.dart';
import 'package:jabaz2/pages/settings.dart';
import 'package:jabaz2/pages/transactions_history.dart';

import '../controllers/account_controller.dart';
import '../controllers/firebase_controllers.dart';

// ignore: must_be_immutable
class MainDrawer extends StatefulWidget {
  BuildContext context;
  // ignore: sort_constructors_first
  MainDrawer(this.context, {Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  // ignore: non_constant_identifier_names
  bool dark_mode = true;
  late Account account;
  bool loadingAccount = true;
  @override
  void initState() {
    fetchUserAccount();
    super.initState();
  }

  fetchUserAccount() async {
    account = await AccountController.getUserAccount(
        context, AppConfig.auth.currentUser!.uid);
    loadingAccount = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            width: 200,
            height: 180,
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          NetworkImage(loadingAccount ? '' : account.image),
                      radius: 30,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          dark_mode ? dark_mode = false : dark_mode = true;
                        });
                      },
                      icon: Icon(
                        dark_mode ? Icons.light_mode : Icons.dark_mode,
                        color: Colors.white,
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: Text(
                    loadingAccount
                        ? "Loading..."
                        : "${account.firstName} ${account.lastName}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  subtitle: Text(loadingAccount ? "Loading..." : account.phone,
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 14,
                        fontFamily: 'Roboto',
                      )),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BookingHistory()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.history,
                size: 30,
              ),
              title: Text(
                "Booking History",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const TransactionsPage(),
                ),
                (route) =>
                    true, //if you want to disable back feature set to false
              );
            },
            child: const ListTile(
              leading: Icon(
                Icons.money,
                size: 30,
              ),
              title: Text(
                "Transaction History",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                );
              },
              child: const ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  title: Text(
                    "Settings",
                    style: TextStyle(
                      color: Color(0xff363636),
                      fontFamily: 'Roboto',
                    ),
                  )),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Share.share('check out my website https://example.com',
                  subject: 'Therapy App');
            },
            child: const ListTile(
              leading: Icon(
                Icons.group_add,
                size: 30,
              ),
              title: Text(
                "Invite Friends",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpPage(),
                ),
              );
            },
            child: const ListTile(
              leading: Icon(
                Icons.help,
                size: 30,
              ),
              title: Text(
                "Support",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              AppConfig.auth.signOut();
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const LoginPage(),
                ),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout,
                size: 30,
              ),
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
