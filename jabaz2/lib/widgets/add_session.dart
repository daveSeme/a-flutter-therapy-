// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:select_form_field/select_form_field.dart';
import 'package:jabaz2/constants/colors.dart';
import 'package:jabaz2/controllers/firebase_controllers.dart';
import 'package:jabaz2/controllers/sessions_controller.dart';
import 'package:jabaz2/data/days.dart';
import 'package:jabaz2/data/time.dart';
import 'package:jabaz2/models/session.dart';
import 'package:jabaz2/utilities/toast_dialog.dart';

import '../utilities/loader.dart';

class AddSessionWidget extends StatefulWidget {
  const AddSessionWidget({Key? key}) : super(key: key);

  @override
  State<AddSessionWidget> createState() => _AddSessionWidgetState();
}

class _AddSessionWidgetState extends State<AddSessionWidget> {
  String day = "";
  String from = "";
  String to = "";
  final TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: false,
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  "SESSION",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(
                thickness: 1.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      "DAY:",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: SelectFormField(
                        decoration: const InputDecoration(
                          hintText: "Select Week Day",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10.0),
                        ),
                        items: days,
                        onChanged: (val) {
                          setState(() {
                            day = val;
                          });
                        },
                        onSaved: (val) => print(val),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      "FROM:",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: SelectFormField(
                        decoration: const InputDecoration(
                          hintText: "Select Start Time",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10.0),
                        ),
                        items: sessionTimes,
                        onChanged: (val) {
                          setState(() {
                            from = val;
                          });
                        },
                        onSaved: (val) => print(val),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      "TO:",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: SelectFormField(
                        decoration: const InputDecoration(
                          hintText: "Select End Time",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10.0),
                        ),
                        items: sessionTimes,
                        onChanged: (val) {
                          setState(() {
                            to = val;
                          });
                        },
                        onSaved: (val) => print(val),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Text(
                      "AMOUNT:",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Enter Amount",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1.0,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (day.isEmpty) {
                    ToastDialogue().showToast("Please select Day", 1);
                  } else if (from.isEmpty) {
                    ToastDialogue().showToast("Please select Starting Time", 1);
                  } else if (to.isEmpty) {
                    ToastDialogue().showToast("Please select Ending Time", 1);
                  } else if (amountController.text.isEmpty) {
                    ToastDialogue().showToast("Amount is Required", 1);
                  } else {
                    String timestamp =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    //Creating Session Object
                    Session session = Session(
                        id: timestamp,
                        specialistId: AppConfig.auth.currentUser!.uid,
                        from: from,
                        to: to,
                        day: day,
                        status: "open",
                        amount: amountController.text.trim());
                    Loader().showCustomDialog(context, "Creating session...");
                    SessionsController.registerNewSession(context, session);
                    ToastDialogue().showToast("Success", 0);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    "Create Session",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
