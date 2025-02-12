import 'package:events/features/Profile/presentation/profile_screen.dart';
import 'package:events/features/community/presentation/community_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                Get.to(CommunitiesListScreen());
              },
              child: const Icon(Icons.people)),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
              onTap: () {
                Get.to(EventsScreen());
              },
              child: Icon(Icons.event)),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: InkWell(
              onTap: () {
                Get.to(ProfileScreen());
              },
              child: Icon(Icons.supervised_user_circle_sharp)),
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
