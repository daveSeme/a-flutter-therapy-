// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:jabaz2/constants/colors.dart';
import 'package:jabaz2/controllers/account_controller.dart';
import 'package:jabaz2/controllers/firebase_controllers.dart';
import 'package:jabaz2/models/user.dart';
import 'package:jabaz2/utilities/loader.dart';
import 'package:jabaz2/utilities/toast_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 0.0,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              leading: GestureDetector(
                  onTap: () {
                    //open Gallery
                    openGallery(context);
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(loadingAccount ? '' : account.image),
                  )),
              title: Text(
                loadingAccount
                    ? "Loading..."
                    : "${account.firstName} ${account.lastName}",
              ),
              subtitle: Text(loadingAccount ? "Loading..." : account.phone),
            ),
            const Divider(
              thickness: 1.0,
            ),
            ListTile(
              leading: const Icon(
                Icons.password,
                size: 30,
              ),
              title: const Text(
                "Change Password",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Roboto',
                ),
              ),
              trailing: IconButton(
                  onPressed: () async {
                    await AppConfig.auth
                        .sendPasswordResetEmail(email: account.email);
                    ToastDialogue().showToast(
                        "An Email has been sent to ${account.email} with instructions to change your password",
                        0);
                  },
                  icon: const Icon(Icons.arrow_forward_ios)),
            ),
            ListTile(
              leading: const Icon(
                Icons.group_add,
                size: 30,
              ),
              title: const Text(
                "Invite Friends",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Roboto',
                ),
              ),
              trailing: IconButton(
                  onPressed: () async {
                    await Share.share(
                        'check out my website https://example.com',
                        subject: 'Therapy App');
                  },
                  icon: const Icon(Icons.arrow_forward_ios)),
            ),
          ],
        ),
      ),
    );
  }

  void openGallery(BuildContext context) async {
    final picker = ImagePicker();
    var image = await picker.getImage(source: ImageSource.gallery);
    // upload(picture);

    if (image!.path.isNotEmpty) {
      Loader().showCustomDialog(context, "Updating...");
      final path = 'files/${image.path}';
      final file = File(image.path);
      final storageRef = FirebaseStorage.instance.ref().child(path);
      UploadTask task = storageRef.putFile(file);

      final snapshot = await task.whenComplete(() {
        log("File Uploaded==========");
      });

      final fileUrl = await snapshot.ref.getDownloadURL();

      if (kDebugMode) {
        print("Download URL: $fileUrl");
      }

      AppConfig.usersRef
          .child(AppConfig.auth.currentUser!.uid)
          .update({'image': fileUrl});

      if (account.role == "therapist") {
        AppConfig.therapistsRef
            .child(AppConfig.auth.currentUser!.uid)
            .update({'image': fileUrl});
      }
      Navigator.pop(context);
      ToastDialogue().showToast("Account Updated", 0);
    }
  }
}
