// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:jabaz2/constants/colors.dart';
import 'package:jabaz2/controllers/firebase_controllers.dart';
import 'package:jabaz2/models/session.dart';
import 'package:jabaz2/widgets/add_session.dart';

class Sessions extends StatefulWidget {
  const Sessions({Key? key}) : super(key: key);

  @override
  State<Sessions> createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAnimatedList(
        controller: scrollController,
        query: AppConfig.sessionsRef.child(AppConfig.auth.currentUser!.uid),
        itemBuilder: (context, snapshot, animation, index) {
          final session = Session.fromSnapshot(snapshot as DocumentSnapshot);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  title: Text("${session.from} - ${session.to}"),
                  subtitle: Text("Ksh. ${session.amount}"),
                  trailing: TextButton(
                      onPressed: () {
                        if (session.status == "open") {
                          AppConfig.sessionsRef
                              .child(session.specialistId)
                              .child(session.id)
                              .remove();
                        }
                      },
                      child: Text(
                        session.status == "open" ? "remove" : session.status,
                        style: TextStyle(
                            color: session.status.contains("booked")
                                ? Colors.green
                                : Colors.red),
                      )),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            isScrollControlled: true,
            backgroundColor: Colors.white,
            context: context,
            builder: (context) => const AddSessionWidget(),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
