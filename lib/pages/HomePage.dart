import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pas1_mobile_11pplg1_25/controllers/Controller.dart';
import 'package:pas1_mobile_11pplg1_25/pages/subPage/AllResults.dart';

import 'subPage/ProfilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MyController controller = Get.find();
  final PageController pageController = PageController(initialPage: 0);
  final titleAdd = TextEditingController();
  final chaptersAdd = TextEditingController();
  final progressAdd = TextEditingController();
  final descriptionAdd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('I was loading this');
    return Center(
      child: Obx(() => Scaffold(
        appBar: AppBar(
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: Colors.blue,
          title: Row(
            children: [
              Text(controller.title.value),
              Expanded(
                child: AnimatedContainer(
                  height: 30,
                  margin: controller.margin.value,
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFF1F1F1),
                  ),

                  //If App Bar is search/home or normal
                  child: tabBar(),
                )
              ),
            ],
          ),
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (newPage){
            controller.changeTab(newPage, MediaQuery.sizeOf(context).width);
          },
          children: [
            AllResults(),
            AllResults.isLiked(),
            ProfilePage()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.index.value,
          backgroundColor: Colors.blue,

          onTap: ((index) {
            changePage(index, context);
          }),

          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite, color: Colors.white),
                label: 'Liked'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.white),
                label: 'Profile'),
          ],
        ),
      )),
    );
  }

  Widget? tabBar(){
    if(controller.index.value == 0){
      return TextField(
        decoration: const InputDecoration(
            icon: Icon(Icons.search),
            border: InputBorder.none,
            isDense: true,
            hintText: "Search"
        ),
        onChanged: (text) {
          controller.changeSearch(text);
        },
      );
    }
    return null;
  }
  void changePage(int index, BuildContext context){
    controller.changeTab(index, MediaQuery.sizeOf(context).width);
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOut
    );
  }
}
