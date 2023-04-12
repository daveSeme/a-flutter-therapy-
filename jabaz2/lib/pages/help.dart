import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/Helper.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.call),
            title: const Text("Call Us"),
            subtitle: const Text("0714599046"),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Helper.makingPhoneCall("0714599046");
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.call,
            color: Colors.green,),
            title: const Text("Whatsapp US"),
            subtitle: const Text("0714599046"),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Helper.launchWhatsApp("+254714599046");
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text("SMS Us"),
            subtitle: const Text("0714599046"),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Helper.launchSMS("799416175", "Info@therapy.co.ke");
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text("Email Us"),
            subtitle: const Text("wandabwafaith@gmail.com"),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Helper.launchEmail("wandabwafaith@gmail.com");
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "*Fresh sessions are generated weekly based depending on the counselors' availability, you pay your deposit which is the commitment fee that is half the money and finish the rest after counseling.*",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
