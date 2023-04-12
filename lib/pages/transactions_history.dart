import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thearapy_app/constants/colors.dart';
import 'package:thearapy_app/models/pay.dart';
import 'package:thearapy_app/models/payment.dart';

import '../controllers/firebase_controllers.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
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
          "Transactions Hostory",
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
                  query: AppConfig.paymentsRef,
                  itemBuilder: (context, snapshot, animation, index) {
                    final json = snapshot.value as Map<dynamic, dynamic>;
                    if (kDebugMode) {
                      print("PAYMENT=======" + json.toString());
                    }
                    final payment = Payment.fromMap(json);

                    return payment.userId == AppConfig.auth.currentUser!.uid &&
                            payment.status == "paid"
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: const Icon(
                                      Icons.payment,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: primaryAccent,
                                  ),
                                  title: Text(
                                    payment.mpesaReceiptNumber,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    payment.phoneNumber,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Ksh ${payment.amount}",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        payment.transactionDate,
                                        style: const TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
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
