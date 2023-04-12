import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jabaz2/pages/specialist_list.dart';
import 'package:jabaz2/pages/transactions_history.dart';
import '../constants/colors.dart';
import '../controllers/account_controller.dart';
import '../controllers/firebase_controllers.dart';
import '../models/therapist.dart';
import '../models/user.dart';
import 'doctor_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Account account;
  bool loadingAccount = true;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    fetchUserAccount();
    super.initState();
  }

  fetchUserAccount() async {
    account = await AccountController.getUserAccount(
        context, AppConfig.auth.currentUser!.uid);
    loadingAccount = false;
    setState(() {});
  }

  void _showDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primaryColor,
      drawer: const Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryColor,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: primaryColor,
          statusBarIconBrightness:
              Brightness.light, // For Android (light icons)
          statusBarBrightness: Brightness.dark, // For iOS (light icons)
        ),
        leading: IconButton(
          onPressed: () => _showDrawer(),
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransactionsPage(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.notifications_rounded,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(loadingAccount ? '' : account.image),
              ),
            ),
          )
        ],
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
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: loadingAccount
                  ? const CircularProgressIndicator(
                      color: Colors.green,
                    )
                  : Text(
                      "Hi, ${account.firstName}",
                      style: const TextStyle(
                        color: Color(0xff363636),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                      ),
                    ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, left: 20),
              child: const Text(
                "Welcome Back",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
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
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   margin: const EdgeInsets.only(top: 20, left: 20),
            //   child: Stack(
            //     fit: StackFit.loose,
            //     children: [
            //       const Text(
            //         'Category',
            //         style: TextStyle(
            //           color: Color(0xff363636),
            //           fontSize: 20,
            //           fontFamily: 'Roboto',
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => const CategoryList()));
            //         },
            //         child: Container(
            //           margin: const EdgeInsets.only(right: 20, top: 1),
            //           child: const Align(
            //             alignment: Alignment.centerRight,
            //             child: Text(
            //               'See all',
            //               style: TextStyle(
            //                 color: Color(0xff5e5d5d),
            //                 fontSize: 19,
            //                 fontFamily: 'Roboto',
            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   height: 120,
            //   margin: const EdgeInsets.only(top: 20, left: 20),
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       demoCategories(
            //           "assets/heart.png", "Mariage", "10 Specialists"),
            //       demoCategories(
            //           "assets/heart.png", "Finance", "15 Specialists"),
            //       demoCategories(
            //           "assets/heart.png", "Career", "17 Specialists"),
            //       demoCategories(
            //           "assets/heart.png", "Parenting", "24 Specialists"),
            //     ],
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  const Text(
                    'Top Rated',
                    style: TextStyle(
                      color: Color(0xff363636),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SpecialistLists()));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 20, top: 1),
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'See all',
                          style: TextStyle(
                            color: Color(0xff5e5d5d),
                            fontSize: 19,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                    ),
                  )
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

  Widget demoCategories(String img, String name, String drCount) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: const Color(0xff107163),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SpecialistLists()));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(img),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xffd9fffa).withOpacity(0.07),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                drCount,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget demoTopRatedDr(String img, String name, String speciality,
      String rating, Therapist therapist) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailPage(
              therapist: therapist,
            ),
          ),
        );
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
