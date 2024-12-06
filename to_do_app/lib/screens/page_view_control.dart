import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/screens/add_screen/add_screen.dart';
import 'package:to_do_app/screens/home_screen/home.dart';
import 'package:to_do_app/screens/search_screen/search_screen.dart';


class PageViewControl extends StatefulWidget {
  const PageViewControl({super.key});

  @override
  State<PageViewControl> createState() => _PageViewControlState();
}

class _PageViewControlState extends State<PageViewControl> {
  final PageController _pageController = PageController();

  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            visit = index;
          });
        },
        children: [
          Home(),
          SearchScreen(),
          AddScreen(),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }


  Widget buildBottomNavigationBar() {
    const List<TabItem> items = [
      TabItem(icon: Icons.home, title: 'HOME'),
      TabItem(icon: Icons.search_sharp, title: 'SEARCH'),
      TabItem(icon: Icons.add_circle_outline, title: 'ADD'),
      //TabItem(icon: Icons.account_box_outlined, title: 'PROFILE'),
    ];

    return BottomBarFloating(
      items: items,
      backgroundColor: green1,
      color: white,
      colorSelected: green3,
      indexSelected: visit,
      paddingVertical: 24,
      onTap: (int index) {
        setState(() {
          visit = index;
          _pageController.jumpToPage(index);
        });
      },
    );
  }
}
