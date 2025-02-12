import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../features/Events/presentation/EventDetailsScreen.dart';
import '../../features/Events/presentation/events_screen.dart';
import '../../features/dashboard/presentation/home_screen.dart';
import '../../features/dashboard/presentation/search_screen.dart';

class bottomnavigationbar extends StatefulWidget {
  int? selectedIndex;
  bottomnavigationbar({super.key, this.selectedIndex});
  @override
  State<bottomnavigationbar> createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<bottomnavigationbar> {


  @override
  Widget build(BuildContext context) {
    int? SelectedIndex = widget.selectedIndex;
    return BottomNavigationBar(
      currentIndex: SelectedIndex!,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
              onTap: () {
                Get.off(EventsScreen());
              },
              child: const Icon(Icons.people)),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
              onTap: () {
                Get.off(HomeScreen());
              },
              child: Icon(Icons.event)),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
              onTap: () {
                Get.off(EventDetailsScreen());
              },
              child: Icon(Icons.message)),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
              onTap: () {
                Get.off(SearchScreen());
              },
              child: Icon(Icons.notifications)),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        setState(() {
          SelectedIndex = index;
        });
      },
    );
  }
}
