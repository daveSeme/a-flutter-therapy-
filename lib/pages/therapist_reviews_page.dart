import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:thearapy_app/controllers/firebase_controllers.dart';
import 'package:thearapy_app/models/review.dart';
import 'package:thearapy_app/models/therapist.dart';
import 'package:thearapy_app/models/user.dart';

import '../constants/colors.dart';

class TherapistReviews extends StatefulWidget {
  Therapist account;
  TherapistReviews({Key? key, required this.account}) : super(key: key);

  @override
  State<TherapistReviews> createState() => _TherapistReviewsState();
}

class _TherapistReviewsState extends State<TherapistReviews> {
   ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          "Coments & Reviews",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.5), //(x,y)
                  blurRadius: 0.5,
                ),
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage(widget.account.image),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dr. ${widget.account.firstName} ${widget.account.lastName}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  Text(
                    widget.account.specialization,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  RatingBar.builder(
                    initialRating: double.parse(widget.account.rating),
                    minRating: 1,
                    itemSize: 30,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Reviews",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        Expanded(
          child: FirebaseAnimatedList(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            query: AppConfig.reviewsRef,
            itemBuilder: (context, snapshot, animation, index) {
              final json = snapshot.value as Map<dynamic, dynamic>;
              if (kDebugMode) {
                print("REVIEW=======" + json.toString());
              }
              final review = Review.fromMap(json);

              return review.booking.therapist.id ==
                      widget.account.id
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
                      backgroundImage:
                          NetworkImage(review.booking.user.image),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.booking.user.firstName +" "+ review.booking.user.lastName,
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(int.parse(review.id)).toLocal().toString(),
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    subtitle: Text(
                       review.message),
                  ),
                )
                  : const SizedBox();
            },
          ),
        ),
      ],
    ),
    );
  }
}
