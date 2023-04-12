import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thearapy_app/constants/colors.dart';
import 'package:thearapy_app/controllers/account_controller.dart';
import 'package:thearapy_app/controllers/firebase_controllers.dart';
import 'package:thearapy_app/models/user.dart';
import 'package:thearapy_app/pages/reservation_history.dart';

import '../pages/login.dart';
import '../pages/settings.dart';
import '../utilities/loader.dart';
import '../utilities/toastDialog.dart';

class TherapistDrawer extends StatefulWidget {
  const TherapistDrawer({Key? key}) : super(key: key);

  @override
  State<TherapistDrawer> createState() => _TherapistDrawerState();
}

class _TherapistDrawerState extends State<TherapistDrawer> {
  // ignore: non_constant_identifier_names
  bool dark_mode = true;
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
    return Drawer(
      child: ListView(
        children: [
          Container(
            width: 200,
            height: 180,
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        openGallery(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            NetworkImage(loadingAccount ? '' : account.image),
                        radius: 30,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          dark_mode ? dark_mode = false : dark_mode = true;
                        });
                      },
                      icon: Icon(
                        dark_mode ? Icons.light_mode : Icons.dark_mode,
                        color: Colors.white,
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: Text(
                    loadingAccount
                        ? "Loading..."
                        : "${account.firstName} ${account.lastName}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  subtitle: Text(loadingAccount ? "Loading..." : account.phone,
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 14,
                        fontFamily: 'Roboto',
                      )),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReservationHistory()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.history,
                size: 30,
              ),
              title: Text(
                "Reservations History",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.settings,
                size: 30,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Roboto',
                ),
              )
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Share.share('check out my website https://example.com',
                  subject: 'Therapy App');
            },
            child: const ListTile(
              leading: Icon(
                Icons.group_add,
                size: 30,
              ),
              title: Text(
                "Invite Friends",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              AppConfig.auth.signOut();
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => const LoginPage(),
                ),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout,
                size: 30,
              ),
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openGallery(BuildContext _context) async {
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

      AppConfig.therapistsRef
          .child(AppConfig.auth.currentUser!.uid)
          .update({'image': fileUrl});
      Navigator.pop(context);
      ToastDialogue().showToast("Account Updated", 0);
    }
  }
}
