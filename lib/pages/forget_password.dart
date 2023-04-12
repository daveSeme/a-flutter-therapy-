import 'package:flutter/material.dart';
import 'package:thearapy_app/constants/colors.dart';
import 'package:thearapy_app/controllers/account_controller.dart';
import 'package:thearapy_app/utilities/toastDialog.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
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
                    ),
                    const Text(
                      "Recover Your Account",
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
                          "Reset You Password",
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
                        child: TextField(
                          controller: emailController,
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
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          if(emailController.text.trim().isNotEmpty){
                             AccountController.resetAccount(context, emailController.text.trim());
                          }
                          else{
                            ToastDialogue().showToast("Email is required", 0);
                          }
                          // Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         type: PageTransitionType.rightToLeft,
                          //         child: const HomePage(), alignment: const Alignment(0, 0)));
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
                              "Reset Password",
                              style: TextStyle(
                                  color: Colors.grey[100],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
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
    );
  }
}
