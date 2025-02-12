// notifications_screen.dart
import 'package:events/features/notifications/models/NotificationModel.dart';
import 'package:flutter/material.dart';


class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  final List<NotificationModel> newNotifications = [
    NotificationModel(
      avatar: 'https://placekitten.com/100/100',
      message: 'Mickey tagged you in a post in SF...',
      timeAgo: '3h',
      isNew: true,
    ),
    NotificationModel(
      avatar: 'https://placekitten.com/101/101',
      message: 'Lei Dong and Yuzi Zhang sent you...',
      timeAgo: '5d',
      isNew: true,
    ),
    NotificationModel(
      avatar: 'https://placekitten.com/102/102',
      message: 'Aileen Yu and Alex Zhang had...',
      timeAgo: '2w',
      isNew: true,
    ),
    NotificationModel(
      avatar: 'https://placekitten.com/103/103',
      message: 'Rahul posted in Real Estate...',
      timeAgo: '1m',
      isNew: true,
    ),
  ];

  final List<NotificationModel> earlierNotifications = [
    NotificationModel(
      avatar: 'https://placekitten.com/104/104',
      message: 'Michie Liu and 4 others had...',
      timeAgo: '3m',
    ),
    NotificationModel(
      avatar: 'https://placekitten.com/105/105',
      message: 'Pentagram, an account you follow,...',
      timeAgo: '4m',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildSectionHeader('New'),
          ...newNotifications.map(_buildNotificationTile),
          _buildSectionHeader('Earlier'),
          ...earlierNotifications.map(_buildNotificationTile),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildNotificationTile(NotificationModel? notification) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundImage: NetworkImage("${notification?.avatar}"),
        radius: 24,
      ),
      title: Text(
        "${notification?.message}",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          "${notification?.timeAgo}",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ),
      onTap: () {
        // Handle notification tap
      },
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: 3, // Notifications tab
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group_outlined),
          label: 'Friends',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_circle_outline),
          label: 'Video',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        // Handle navigation
      },
    );
  }
}

// To use time-ago formatting, you might want to add a helper:
String getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 7) {
    final weeks = (difference.inDays / 7).floor();
    return '${weeks}w';
  } else if (difference.inDays > 0) {
    return '${difference.inDays}d';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m';
  } else {
    return 'now';
  }
}