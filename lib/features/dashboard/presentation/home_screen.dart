import 'package:events/features/Events/presentation/EventDetailsScreen.dart';
import 'package:events/features/Events/presentation/events_screen.dart';
import 'package:events/features/dashboard/presentation/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Profile/presentation/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _currentTab = "All";
 final List<Post> _posts = [
    Post(
      avatar: 'https://raw.githubusercontent.com/Air908/3dmodels/refs/heads/main/smiling-young-man-illustration_1308-173524.avif',
      title: 'The 8th annual Women in Tech...',
      category: 'Tech Talk',
    ),
    Post(
      avatar: 'https://raw.githubusercontent.com/Air908/3dmodels/refs/heads/main/smiling-young-man-illustration_1308-173524.avif',
      title: 'Chloe: I\'m looking for a new job in the...',
      category: 'Tech Talk',
    ),
    Post(
      avatar: 'https://raw.githubusercontent.com/Air908/3dmodels/refs/heads/main/3d_woman.avif',
      title: 'Natalie: I just got an offer from...',
      category: 'Tech Talk',
    ),
    Post(
avatar: 'https://raw.githubusercontent.com/Air908/3dmodels/refs/heads/main/3d_woman.avif',
      title: 'How do you manage your work life...',
      category: 'Tech Talk',
    ),
    Post(
      avatar: 'https://raw.githubusercontent.com/Air908/3dmodels/refs/heads/main/smiling-young-man-illustration_1308-173524.avif',
      title: 'I\'m thinking of moving to a smaller...',
      category: 'Tech Talk',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Get.to(ProfileScreen());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                _buildTab("All"),
                _buildTab("Following"),
                _buildTab("Saved"),
              ],
            ),
          ),
          // Posts List
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return _buildPostItem(_posts[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: InkWell( onTap:(){
              Get.off(EventsScreen());
            }, child: const Icon(Icons.people)),
            label: 'Network',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: (){
                  Get.off(HomeScreen());
                },
                child: Icon(Icons.work)),
            label: 'Jobs',
          ),
           BottomNavigationBarItem(
            icon: InkWell(
                onTap: (){
                  Get.off(EventDetailsScreen());
                },
                child: Icon(Icons.message)),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
                onTap: (){
                  Get.off(SearchScreen());
                },
                child: Icon(Icons.notifications)),
            label: 'Notifications',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildTab(String title) {
    bool isSelected = _currentTab == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentTab = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildPostItem(Post post) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(post.avatar),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  post.category,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Post {
  final String avatar;
  final String title;
  final String category;

  Post({
    required this.avatar,
    required this.title,
    required this.category,
  });
}