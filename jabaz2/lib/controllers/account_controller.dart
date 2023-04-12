// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/address.dart';
import '../models/therapist.dart';
import '../models/user.dart';
import '../pages/home_page.dart';
import '../pages/login.dart';
import '../pages/therapist_dashboard.dart';
import '../utilities/loader.dart';
import '../utilities/toast_dialog.dart';
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
            rating: "2.5",
            physicalAddress: 'false');

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
      ToastDialogue().showToast("Error: $e", 1);
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
      ToastDialogue().showToast("Error: $e", 1);
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
      ToastDialogue().showToast("Error: $e", 1);
    }
  }

  static Future<Account> getUserAccount(
      BuildContext context, String uid) async {
    return Account.fromSnapshot(
        (await AppConfig.usersRef.child(uid).once()) as DocumentSnapshot);
  }

  static Future<Therapist> getTherapistAccount(
      BuildContext context, String uid) async {
    return Therapist.fromSnapshot(
        (await AppConfig.therapistsRef.child(uid).once()) as DocumentSnapshot);
  }

  static Future<Address> getTherapistAddress(
      BuildContext context, String uid) async {
    return Address.fromSnapshot(
        (await AppConfig.locationsRef.child(uid).once()) as DocumentSnapshot);
  }
}
