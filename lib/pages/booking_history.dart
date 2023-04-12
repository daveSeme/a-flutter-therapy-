import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:thearapy_app/constants/colors.dart';
import 'package:thearapy_app/controllers/account_controller.dart';
import 'package:thearapy_app/controllers/firebase_controllers.dart';
import 'package:thearapy_app/models/address.dart';
import 'package:thearapy_app/models/booking.dart';
import 'package:thearapy_app/pages/review_session.dart';
import 'package:thearapy_app/utilities/toastDialog.dart';
import 'package:thearapy_app/utils/Helper.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          "Booking History",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    offset: Offset(0, 10),
                    blurRadius: 15,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: const TextField(
                        maxLines: 1,
                        autofocus: false,
                        style:
                            TextStyle(color: Color(0xff107163), fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search..',
                        ),
                        cursorColor: Color(0xff107163),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: primaryAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: FirebaseAnimatedList(
                  controller: scrollController,
                  query: AppConfig.bookingsRef,
                  itemBuilder: (context, snapshot, animation, index) {
                    final json = snapshot.value as Map<dynamic, dynamic>;
                    print("BOOKING=======" + json.toString());
                    final booking = Booking.fromMap(json);

                    return booking.user.id == AppConfig.auth.currentUser!.uid
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            booking.session.day,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      title: Text(booking.session.from +
                                          " - " +
                                          booking.session.to),
                                      subtitle: Text(
                                          "Ksh. ${booking.session.amount}"),
                                      trailing: TextButton(
                                        child: Text(
                                          booking.paymentStatus == "completed"
                                              ? "Review"
                                              : "Cancel",
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                        onPressed: () {
                                          if (booking.paymentStatus
                                              .contains("pending")) {
                                            //delete booking
                                            AppConfig.bookingsRef
                                                .child(booking.id)
                                                .remove();

                                            //update session status to open
                                            Map<String, dynamic> status = {
                                              "status": "open"
                                            };
                                            AppConfig.sessionsRef
                                                .child(booking.therapist.id)
                                                .child(booking.session.id)
                                                .update(status);
                                            ToastDialogue()
                                                .showToast("Sucess", 0);
                                          } else {
                                            //review
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ReviewPage(
                                                  booking: booking,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: primaryColor,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Therapist Details"),
                                          booking.physical == "true"
                                              ? IconButton(
                                                  onPressed: () async {
                                                    if (booking.paymentStatus !=
                                                        "completed") {
                                                      Address address =
                                                          await AccountController
                                                              .getTherapistAddress(
                                                                  context,
                                                                  booking
                                                                      .therapist
                                                                      .id);
                                                      Helper.openMap(
                                                          double.parse(
                                                              address.latitude),
                                                          double.parse(address
                                                              .longitude));
                                                    } else {
                                                      ToastDialogue().showToast(
                                                          "This session is nolonger active",
                                                          1);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.navigation,
                                                    color: Colors.green,
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                    ListTile(
                                      leading: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                            booking.therapist.image),
                                      ),
                                      title: Text(
                                        "Dr ${booking.therapist.firstName} ${booking.therapist.lastName}",
                                        style: const TextStyle(
                                          color: Color(0xff363636),
                                          fontSize: 17,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      subtitle: Text(
                                        booking.therapist.specialization,
                                        style: const TextStyle(
                                          color: Color(0xffababab),
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      trailing: Text(
                                        "Rating: ${booking.therapist.rating}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
