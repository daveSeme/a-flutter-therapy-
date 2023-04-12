import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:jabaz2/constants/colors.dart';
import 'package:jabaz2/controllers/firebase_controllers.dart';

import '../models/therapist.dart';
import 'doctor_details_page.dart';

class SpecialistLists extends StatefulWidget {
  const SpecialistLists({Key? key}) : super(key: key);

  @override
  State<SpecialistLists> createState() => _SpecialistListsState();
}

class _SpecialistListsState extends State<SpecialistLists> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          "Specialists",
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
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: FirebaseAnimatedList(
                  controller: scrollController,
                  query: AppConfig.therapistsRef,
                  itemBuilder: (context, snapshot, animation, index) {
                    final therapist = Therapist.fromSnapshot(snapshot as DocumentSnapshot);
                    return demoTopRatedDr(
                      "assets/profile.jpeg",
                      "Dr ${therapist.firstName} ${therapist.lastName}",
                      therapist.specialization,
                      therapist.rating,
                      therapist,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget demoTopRatedDr(String img, String name, String speciality,
      String rating, Therapist therapist) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorDetailPage(
                      therapist: therapist,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(therapist.image),
          ),
          title: Text(
            name,
            style: const TextStyle(
              color: Color(0xff363636),
              fontSize: 17,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            speciality,
            style: const TextStyle(
              color: Color(0xffababab),
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w300,
            ),
          ),
          trailing: Text(
            "Rating: $rating",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }
}
