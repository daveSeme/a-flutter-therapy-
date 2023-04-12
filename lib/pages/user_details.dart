import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:thearapy_app/constants/constants.dart';
import 'package:thearapy_app/models/user.dart';
import 'package:thearapy_app/pages/sign_up.dart';
import 'package:thearapy_app/utils/PageTransistor.dart';

import '../constants/colors.dart';
import 'login.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
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
                        "Personal Details",
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
                              "Personal Details",
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
                              controller: firstNameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter First Name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'First Name',
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
                              controller: lastNameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Last Name';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Last Name',
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
                              controller: phoneController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Phone';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Phone',
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
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                Account user = Account(
                                    id: "",
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    phone: phoneController.text,
                                    email: "",
                                    role: "user",
                                    image: "");
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: SignupPage(
                                          user: user,
                                        ),
                                        alignment: const Alignment(0, 0)));
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 30),
                              height: 45,
                              decoration: BoxDecoration(
                                color: primaryAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Proceed",
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
                                            decoration: TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    child: const LoginPage(),
                                                    alignment:
                                                        const Alignment(0, 0)));
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
