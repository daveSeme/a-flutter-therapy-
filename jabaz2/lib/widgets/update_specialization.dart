import 'package:flutter/material.dart';
import 'package:jabaz2/controllers/firebase_controllers.dart';
import 'package:jabaz2/utilities/toast_dialog.dart';

import '../constants/colors.dart';

class UpdateSpecializationWidget extends StatefulWidget {
  const UpdateSpecializationWidget({Key? key}) : super(key: key);

  @override
  State<UpdateSpecializationWidget> createState() =>
      _UpdateSpecializationWidgetState();
}

class _UpdateSpecializationWidgetState
    extends State<UpdateSpecializationWidget> {
  final TextEditingController specilization = TextEditingController();
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
                  "SPECIALIZATION",
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
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: TextField(
                    controller: specilization,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Enter Specialization",
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                    ),
                  ),
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
                  if (specilization.text.isNotEmpty) {
                    AppConfig.therapistsRef
                        .child(AppConfig.auth.currentUser!.uid)
                        .update({"specialization": specilization.text.trim()});
                    ToastDialogue().showToast("Success", 0);
                    Navigator.pop(context);
                  } else {
                    ToastDialogue().showToast("Specialization is empty", 1);
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
                    "Update Specialization",
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
