// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thearapy_app/controllers/account_controller.dart';
import 'package:thearapy_app/controllers/firebase_controllers.dart';
import 'package:thearapy_app/models/user.dart';
import 'package:thearapy_app/pages/home_page.dart';
import 'package:thearapy_app/pages/login.dart';
import 'package:thearapy_app/pages/therapist_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String role = "";
  @override
  void initState() {
    if(AppConfig.auth.currentUser != null)fetchUser();
    super.initState();
  }

  fetchUser()async{
   Account account = await AccountController.getUserAccount(context, AppConfig.auth.currentUser.uid);
   role = account.role;
   setState(() {
     
   });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppConfig.auth.currentUser == null ? const LoginPage()
      : role.contains("user") ? const HomePage() : const TherapistDashboard(),
    );
  }
}
