import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'specialist_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          "Categories",
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
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: GridView(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // number of items per row
                    crossAxisCount: 3,
                    // vertical spacing between the items
                    mainAxisSpacing: 10,
                    // horizontal spacing between the items
                    crossAxisSpacing: 10,
                  ),
                  children: [
                    demoCategories(
                        "assets/heart.png", "Mariage", "10 Specialists"),
                    demoCategories(
                        "assets/heart.png", "Finance", "15 Specialists"),
                    demoCategories(
                        "assets/heart.png", "Career", "17 Specialists"),
                    demoCategories(
                        "assets/heart.png", "Parenting", "24 Specialists"),
                    demoCategories(
                        "assets/heart.png", "Mariage", "10 Specialists"),
                    demoCategories(
                        "assets/heart.png", "General", "15 Specialists"),
                   
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget demoCategories(String img, String name, String drCount) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SpecialistLists()));
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: const Color(0xff107163),
          borderRadius: BorderRadius.circular(10),
        ),
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
}
