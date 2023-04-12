import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thearapy_app/constants/colors.dart';
import 'package:thearapy_app/utilities/loader.dart';
import 'package:thearapy_app/widgets/update_specialization.dart';

import '../controllers/account_controller.dart';
import '../controllers/firebase_controllers.dart';
import '../models/user.dart';
import '../utilities/toastDialog.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool fetchingLocation = true;
  late Account account;
  bool loadingAccount = true;
  late Position currentPosition;
  String message = "Searching Your location...";
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
    return Column(
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
                await Share.share('check out my website https://example.com',
                    subject: 'Therapy App');
              },
              icon: const Icon(Icons.arrow_forward_ios)),
        ),
        ListTile(
          leading: const Icon(
            Icons.card_giftcard,
            size: 30,
          ),
          title: const Text(
            "Update Specialization",
            style: TextStyle(
              color: Color(0xff363636),
              fontFamily: 'Roboto',
            ),
          ),
          trailing: IconButton(
              onPressed: () async {
                showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (context) => const UpdateSpecializationWidget(),
                );
              },
              icon: const Icon(Icons.arrow_forward_ios)),
        ),
        ListTile(
          leading: const Icon(
            Icons.location_city,
            size: 30,
          ),
          title: const Text(
            "Add Office Address",
            style: TextStyle(
              color: Color(0xff363636),
              fontFamily: 'Roboto',
            ),
          ),
          trailing: IconButton(
              onPressed: () async {
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.location,
                ].request();
                print(statuses[Permission.location]);
                if (statuses[Permission.location]!.isDenied) {
                  requestPermission(Permission.location);
                } else {
                  locatePosition();
                }
              },
              icon: const Icon(Icons.arrow_forward_ios)),
        ),
      ],
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

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
  }

  void locatePosition() async {
    Loader().showCustomDialog(context, message);
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    print("THIS IS YOUR ADDRESS:::LAT: ${currentPosition.latitude} LONG: ${currentPosition.longitude}");
    
    setState(() {
      message = "Updating Your Address";
    });
    Navigator.pop(context);
    Loader().showCustomDialog(context, message);
    AppConfig.locationsRef.child(AppConfig.auth.currentUser!.uid).set({
      "latitude": currentPosition.latitude.toString(),
      "longitude": currentPosition.longitude.toString(),
      "id": AppConfig.auth.currentUser!.uid,
    });
    Navigator.pop(context);
    ToastDialogue().showToast("Sucess", 0);
  }
}
