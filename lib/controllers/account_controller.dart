import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thearapy_app/models/address.dart';
import 'package:thearapy_app/models/therapist.dart';
import 'package:thearapy_app/models/user.dart';
import 'package:thearapy_app/pages/home_page.dart';
import 'package:thearapy_app/pages/login.dart';
import 'package:thearapy_app/pages/therapist_dashboard.dart';
import 'package:thearapy_app/utilities/loader.dart';
import 'package:thearapy_app/utilities/toastDialog.dart';

import 'firebase_controllers.dart';

class AccountController {
  static registerNewUser(
      BuildContext context, Account account, String password) async {
    try {
      Loader().showCustomDialog(context, "Registering");
      UserCredential userCredential = await AppConfig.auth
          .createUserWithEmailAndPassword(
              email: account.email, password: password);

      //redefining User object and assign User ID from the Auth
      Account user = Account(
          id: userCredential.user!.uid,
          firstName: account.firstName,
          lastName: account.lastName,
          phone: account.phone,
          email: account.email,
          role: account.role,
          image: "");
      // saving user data to database
      AppConfig.usersRef.child(userCredential.user!.uid).set(user.toMap());

      if (account.role.contains("user")) {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const HomePage(),
          ),
          (route) => false, //if you want to disable back feature set to false
        );
      } else {

        Therapist therapist = Therapist(
            id: userCredential.user!.uid,
            firstName: account.firstName,
            lastName: account.lastName,
            phone: account.phone,
            email: account.email,
            specialization: "General",
            image: "",
            rating: "2.5", physical_address: 'false');

        // saving user data to database
        AppConfig.therapistsRef
            .child(userCredential.user!.uid)
            .set(therapist.toMap());
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const TherapistDashboard(),
          ),
          (route) => false, //if you want to disable back feature set to false
        );
      }
    } catch (e) {
      ToastDialogue().showToast("Error: " + e.toString(), 1);
    }
  }

  static loginUser(BuildContext context, String email, String password) async {
    try {
      Loader().showCustomDialog(context, "Signing in...");
      final UserCredential userCredential = (await AppConfig.auth
          .signInWithEmailAndPassword(email: email, password: password));

      //get user role
      Account account = await getUserAccount(context, userCredential.user!.uid);
      if (kDebugMode) {
        print("ACCOUNT************${account.toString()}");
      }
      Navigator.pop(context);
      ToastDialogue().showToast("Success", 0);
      if (account.role.contains("user")) {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const HomePage(),
          ),
          (route) => false, //if you want to disable back feature set to false
        );
      } else {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const TherapistDashboard(),
          ),
          (route) => false, //if you want to disable back feature set to false
        );
      }
    } catch (e) {
      ToastDialogue().showToast("Error: " + e.toString(), 1);
    }
  }

  static resetAccount(BuildContext context, String email) async {
    Loader().showCustomDialog(context, "Sending email...");
    try {
      await AppConfig.auth.sendPasswordResetEmail(email: email);
      Navigator.pop(context);
      ToastDialogue().showToast(
          "Sent, Check your mailbox for the password recovery email", 0);
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const LoginPage(),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
    } catch (e) {
      ToastDialogue().showToast("Error: " + e.toString(), 1);
    }
  }

  static Future<Account> getUserAccount(
      BuildContext context, String uid) async {
    return Account.fromSnapshot(await AppConfig.usersRef.child(uid).once());
  }

   static Future<Therapist> getTherapistAccount(
      BuildContext context, String uid) async {
    return Therapist.fromSnapshort(await AppConfig.therapistsRef.child(uid).once());
  }

  static Future<Address> getTherapistAddress(
      BuildContext context, String uid) async {
    return Address.fromSnapshort(await AppConfig.locationsRef.child(uid).once());
  }
}
