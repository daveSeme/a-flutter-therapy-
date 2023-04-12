import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:thearapy_app/constants/Constants.dart';
import 'package:thearapy_app/constants/colors.dart';
import 'package:thearapy_app/controllers/account_controller.dart';
import 'package:thearapy_app/models/user.dart';
import 'package:thearapy_app/pages/terms_and_conditions.dart';
import 'package:thearapy_app/utilities/loader.dart';
import 'package:thearapy_app/utilities/toastDialog.dart';

import '../utils/PageTransistor.dart';
import 'login.dart';

// ignore: must_be_immutable
class SignupPage extends StatefulWidget {
  Account user;
  SignupPage({Key? key, required this.user}) : super(key: key);
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _value = false;
  bool registerAsTherapist = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.centerRight,
                colors: [
                  Color(0xff053F5E),
                  Color(0xff053F5E),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          Text(
                            "Back",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const Text(
                        "Sign up Account",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      Container(),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Create An Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.all(20),
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.indigo,
                              ),
                            ),
                            child: TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Email';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10),
                                hintStyle: TextStyle(
                                    fontSize: 14.0, color: Colors.black54),
                              ),
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(20),
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.indigo,
                              ),
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10),
                                hintStyle: TextStyle(
                                    fontSize: 14.0, color: Colors.black54),
                              ),
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(20),
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.indigo,
                              ),
                            ),
                            child: TextFormField(
                              controller: password2Controller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Confirm Password';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Confirm Password',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10),
                                hintStyle: TextStyle(
                                    fontSize: 14.0, color: Colors.black54),
                              ),
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CheckboxListTile(
                            title: Row(
                              children: [
                                const Text(
                                  "I accept",
                                  style: TextStyle(color: Colors.black54),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  child: const Text(
                                    "Terms and conditions",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                        fontSize: 12),
                                  ),
                                  onTap: () {
                                    //oppening terms
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const TermsAndConditions(),
                                        alignment: const Alignment(0, 0),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            value: _value,
                            onChanged: (newValue) {
                              setState(() {
                                _value = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                          CheckboxListTile(
                            title: const Text(
                              "Register as a therapist",
                              style: TextStyle(fontSize: 14),
                            ),
                            value: registerAsTherapist,
                            onChanged: (newValue) {
                              setState(() {
                                registerAsTherapist = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                if (passwordController.text.trim() ==
                                    password2Controller.text.trim()) {
                                  Account account = Account(
                                      id: "",
                                      firstName: widget.user.firstName,
                                      lastName: widget.user.lastName,
                                      phone: widget.user.phone,
                                      email: emailController.text.trim(),
                                      role: registerAsTherapist
                                          ? "therapist"
                                          : "user",
                                          image: "");
                                  AccountController.registerNewUser(context,
                                      account, passwordController.text.trim());
                                } else {
                                  ToastDialogue()
                                      .showToast("Password do not match", 1);
                                }
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              height: 45,
                              decoration: BoxDecoration(
                                color: primaryAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.grey[100],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: GestureDetector(
                              child: RichText(
                                text: TextSpan(
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 16),
                                    children: <TextSpan>[
                                      const TextSpan(
                                          text: "Already have an account?"),
                                      TextSpan(
                                        text: " Login.",
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: const LoginPage(),
                                                alignment:
                                                    const Alignment(0, 0),
                                              ),
                                            );
                                          },
                                      ),
                                    ]),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const LoginPage(),
                                        alignment: const Alignment(0, 0)));
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
