
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jabaz2/pages/user_details.dart';
import '../constants/colors.dart';
import '../constants/constants.dart';
import '../controllers/account_controller.dart';
import '../utils/page_transistor.dart';
import 'forget_password.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _value = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.centerRight,
                colors: [
                  primaryColor,
                  primaryColor,
                ],
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                          "Sign In Account",
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Welcome Back",
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
                                  return 'Enter Email Address';
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
                              obscureText: true,
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password';
                                }
                                return null;
                              },
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
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value
                                                ? _value = false
                                                : _value = true;
                                          });
                                        }),
                                    Text(
                                      "Remember me",
                                      style: TextStyle(
                                          color: Colors.indigo[300],
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: const ForgetPasswordPage(),
                                            alignment: const Alignment(0, 0)));
                                  },
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                        color: Colors.indigo[300],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                AccountController.loginUser(
                                    context,
                                    emailController.text.trim(),
                                    passwordController.text.trim());
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
                                  "Login in",
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
                          GestureDetector(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 16),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: "Do not have an account?"),
                                    TextSpan(
                                      text: " Register.",
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child:
                                                      const PersonalDetails(),
                                                  alignment:
                                                      const Alignment(0, 0)));
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const PersonalDetails(),
                                      alignment: const Alignment(0, 0)));
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
