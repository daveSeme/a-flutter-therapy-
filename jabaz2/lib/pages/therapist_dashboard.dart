import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jabaz2/constants/colors.dart';
import 'package:jabaz2/pages/reservation_history.dart';
import 'package:jabaz2/widgets/profile.dart';
import 'package:jabaz2/widgets/reviews.dart';
import 'package:jabaz2/widgets/sessions.dart';
import '../widgets/home.dart';
import '../widgets/therapist_drawer.dart';

class TherapistDashboard extends StatefulWidget {
  const TherapistDashboard({Key? key}) : super(key: key);

  @override
  State<TherapistDashboard> createState() => _TherapistDashboardState();
}

class _TherapistDashboardState extends State<TherapistDashboard> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const TherapistDrawer(),
        appBar: AppBar(
          title: const Text("Dashboard"),
          backgroundColor: primaryColor,
          elevation: 0.0,
          actions: [
            SizedBox(
              width: 50,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ReservationHistory()));
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.notifications,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        body: selectedIndex == 0
            ? const HomeWidget()
            : selectedIndex == 1
                ? const Sessions()
                : selectedIndex == 2
                    ? const Reviews()
                    : const Profile(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar),
              label: 'Sessions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.reviews),
              label: 'Reviews',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.profile_circled),
              label: 'Profile',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: primaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
