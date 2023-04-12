// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jabaz2/constants/colors.dart';
import 'package:jabaz2/controllers/firebase_controllers.dart';
import 'package:jabaz2/models/booking.dart';
import 'package:jabaz2/utils/Helper.dart';

import '../controllers/account_controller.dart';
import '../models/user.dart';
import '../utilities/toast_dialog.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  ScrollController scrollController = ScrollController();

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 120,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Hello ${loadingAccount ? '' : 'Dr ${account.firstName} ${account.lastName}!'}\nLets Find you Clients",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Recent Reservations",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: FirebaseAnimatedList(
            controller: scrollController,
            query: AppConfig.bookingsRef,
            itemBuilder: (context, snapshot, animation, index) {
              final json = snapshot.value as Map<dynamic, dynamic>;
              if (kDebugMode) {
                print("BOOKING=======$json");
              }
              final booking = Booking.fromMap(json);

              return booking.therapist.id == AppConfig.auth.currentUser!.uid &&
                      booking.paymentStatus.contains("completed")
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.5), //(x,y)
                            blurRadius: 0.5,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 30,
                          backgroundImage: NetworkImage(booking.user.image),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${booking.user.firstName} ${booking.user.lastName}",
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "General Consultations",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                "${booking.session.from} - ${booking.session.to}"),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Helper.makingPhoneCall(booking.user.phone);
                                  },
                                  child: const CircleAvatar(
                                    child: Icon(Icons.phone),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Helper.launchWhatsApp(booking.user.phone);
                                  },
                                  child: const CircleAvatar(
                                    child: FaIcon(FontAwesomeIcons.whatsapp),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Helper.launchSMS(booking.user.phone,
                                        booking.user.firstName);
                                  },
                                  child: const CircleAvatar(
                                    child: Icon(Icons.message),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: TextButton(
                          child: const Text(
                            "Done",
                          ),
                          onPressed: () {
                            if (booking.description.contains("done")) {
                              ToastDialogue().showToast(
                                  "This session is already marked Done", 1);
                            } else {
                              AppConfig.bookingsRef
                                  .child(booking.id)
                                  .update({"description": "done"});
                              //update session status to open
                              Map<String, dynamic> status = {"status": "open"};
                              AppConfig.sessionsRef
                                  .child(booking.therapist.id)
                                  .child(booking.session.id)
                                  .update(status);
                              ToastDialogue().showToast("Success", 0);
                            }
                          },
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
