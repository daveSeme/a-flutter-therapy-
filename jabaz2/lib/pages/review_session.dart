import 'package:flutter/material.dart';
import 'package:jabaz2/models/booking.dart';
import 'package:jabaz2/constants/colors.dart';
import 'package:jabaz2/controllers/firebase_controllers.dart';
import 'package:jabaz2/models/booking.dart';
import 'package:jabaz2/models/review.dart';
import 'package:jabaz2/pages/home_page.dart';
import 'package:jabaz2/utilities/toast_dialog.dart';

class ReviewPage extends StatefulWidget {
  Booking booking;
  ReviewPage({required this.booking});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryColor,
        title: const Text("Review Session"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: .5, color: Colors.grey)),
            child: TextField(
              controller: messageController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Message",
                hintStyle: TextStyle(color: Colors.black54),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0.0),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (messageController.text.isEmpty) {
                ToastDialogue().showToast("Please enter message", 1);
                return;
              }

              String timestamp =
                  DateTime.now().millisecondsSinceEpoch.toString();

              Review review = Review(
                  message: messageController.text.trim(),
                  id: timestamp,
                  booking: widget.booking);
              AppConfig.reviewsRef.child(timestamp).set(review.toMap());

              ToastDialogue().showToast("Review Sent", 0);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(5)),
              child: const Center(
                child: Text(
                  "Send Message",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
