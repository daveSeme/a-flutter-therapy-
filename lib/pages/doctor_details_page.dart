// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thearapy_app/constants/colors.dart';
import 'package:thearapy_app/controllers/account_controller.dart';
import 'package:thearapy_app/controllers/firebase_controllers.dart';
import 'package:thearapy_app/controllers/payment_controller.dart';
import 'package:thearapy_app/models/address.dart';
import 'package:thearapy_app/models/booking.dart';
import 'package:thearapy_app/models/pay.dart';
import 'package:thearapy_app/models/session.dart';
import 'package:thearapy_app/models/therapist.dart';
import 'package:thearapy_app/pages/therapist_reviews_page.dart';
import 'package:thearapy_app/utilities/toastDialog.dart';

// ignore: must_be_immutable
class DoctorDetailPage extends StatefulWidget {
  Therapist therapist;
  DoctorDetailPage({Key? key, required this.therapist}) : super(key: key);

  @override
  _DoctorDetailPageState createState() => _DoctorDetailPageState();
}

class _DoctorDetailPageState extends State<DoctorDetailPage> {
  ScrollController scrollController = ScrollController();
  Address address = Address(id: "", latitude: "", longitude: "");
  bool loadingAddress = true;
  bool checkedValue = false;
  @override
  void initState() {
    fetchTherapistAddress();
    super.initState();
  }

  fetchTherapistAddress() async {
    address = await AccountController.getTherapistAddress(
        context, widget.therapist.id);
    setState(() {
      loadingAddress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff053F5E),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TherapistReviews(
                    account: widget.therapist,
                  ),
                ),
              );
            },
            child: const Text(
              "Reviews",
              style: TextStyle(color: Colors.amber),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Color(0xff053F5E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 30, bottom: 30),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(widget.therapist.image),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Text(
                            'Dr. ${widget.therapist.firstName} ${widget.therapist.lastName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            widget.therapist.specialization,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Text(
                            'Rating: ${widget.therapist.rating}',
                            style: const TextStyle(
                              color: Colors.yellow,
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !loadingAddress && address.id.isNotEmpty,
            child: CheckboxListTile(
              title: const Text(
                "Apply Physical Session (Optional)",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              value: checkedValue,
              onChanged: (newValue) {
                setState(() {
                  checkedValue = newValue!;
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, //  <-- leading Checkbox
            ),
          ),
          Expanded(
              child: FirebaseAnimatedList(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            query: AppConfig.sessionsRef.child(widget.therapist.id),
            itemBuilder: (context, snapshot, animation, index) {
              final session = Session.fromSnapshort(snapshot);
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            session.day,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                      title: Text(session.from + " - " + session.to),
                      subtitle: Text("Ksh. ${session.amount}"),
                      trailing: session.status.contains("open")
                          ? TextButton(
                              onPressed: () {
                                showConfirmationDialog(session);
                              },
                              child: const Text("Book"))
                          : Text(session.status),
                    ),
                  ),
                ),
              );
            },
          )),
        ],
      ),
    );
  }

  Future<void> showConfirmationDialog(Session session) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(session.day + " ${session.from} - ${session.to} Session"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'After clicking Confirm you are going to receive an MPESA pop up to pay Ksh ${session.amount} to complete your booking'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () async {
                ToastDialogue().showToast("Sending request...", 0);
                Map<String, dynamic> status = {"status": "booked"};
                AppConfig.sessionsRef
                    .child(widget.therapist.id)
                    .child(session.id)
                    .update(status);

                String timestamp =
                    DateTime.now().millisecondsSinceEpoch.toString();

                Booking booking = Booking(
                    id: timestamp,
                    therapist: widget.therapist,
                    session: session,
                    user: await AccountController.getUserAccount(
                        context, AppConfig.auth.currentUser!.uid),
                    description: "",
                    paymentStatus: 'pending',
                    physical: checkedValue.toString());
                // saving booking data to database
                AppConfig.bookingsRef.child(timestamp).set(booking.toMap());

                //send HTTP Request
                Pay pay = Pay(
                    bookingId: timestamp,
                    userId: AppConfig.auth.currentUser!.uid,
                    amount: session.amount,
                    phone: await AccountController.getUserAccount(
                            context, AppConfig.auth.currentUser!.uid)
                        .then((value) =>
                            "254" +
                            value.phone.substring(value.phone.length - 9)));
                var resp = await PaymentController.pay(pay);
                Navigator.of(context).pop();

                if (kDebugMode) {
                  print("RESPONSE: $resp");
                }
                ToastDialogue().showToast("Success", 0);
              },
            ),
          ],
        );
      },
    );
  }
}
