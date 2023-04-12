import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:thearapy_app/constants/colors.dart';
import 'package:thearapy_app/controllers/firebase_controllers.dart';
import 'package:thearapy_app/models/booking.dart';
import 'package:thearapy_app/utilities/toastDialog.dart';
import 'package:thearapy_app/utils/Helper.dart';

class ReservationHistory extends StatefulWidget {
  const ReservationHistory({Key? key}) : super(key: key);

  @override
  State<ReservationHistory> createState() => _ReservationHistoryState();
}

class _ReservationHistoryState extends State<ReservationHistory> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: const Text("Reservations"),
      ),
      body: FirebaseAnimatedList(
        controller: scrollController,
        query: AppConfig.bookingsRef,
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          print("BOOKING=======" + json.toString());
          final booking = Booking.fromMap(json);

          return booking.therapist.id == AppConfig.auth.currentUser!.uid &&
                  booking.paymentStatus.contains("completed")
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                          booking.user.firstName + " " + booking.user.lastName,
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
                        Text("${booking.session.from} - ${booking.session.to}"),
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
                                Helper.launchSMS(
                                    booking.user.phone, booking.user.firstName);
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
                          ToastDialogue().showToast("Sucess", 0);
                        }
                      },
                    ),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
