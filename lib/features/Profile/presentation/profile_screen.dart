import 'package:events/features/Profile/controller/profileController.dart';
import 'package:events/features/setttings/presentation/notifications_settings_screen.dart';
import 'package:events/shared/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../setttings/presentation/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildUserInfo(),
              _buildInterests(),
      _buildTabSection(),
            Obx(()=>  profileController.isCommunitySelected.value == true ?
                _buildPosts():SizedBox()),
             Obx(()=>  profileController.isEventSelected.value == true ? _buildEvent() :SizedBox(),
            ),
              ],
          ),
          ),
        ),
      bottomNavigationBar: bottomnavigationbar(selectedIndex: 3),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.to(SettingsScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                const AssetImage('lib/shared/assets/images/welcome.png'),
          ),
          const SizedBox(height: 16),
          const Text(
            'John, male, age 29',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'New York, Joined in 2019',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _buildInterests() {
    final interests = ['Football', 'Golf', 'Tennis', 'Travel', 'Hiking'];
    final icons = [
      Icons.sports_football,
      Icons.sports_golf,
      Icons.sports_tennis,
      Icons.flight,
      Icons.hiking,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: List.generate(
          interests.length,
          (index) => Container(
            margin: const EdgeInsets.only(right: 8),
            child: Chip(
              avatar: Icon(icons[index], size: 16),
              label: Text(interests[index]),
              backgroundColor: Colors.grey[200],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabSection() {
    return  Obx( ()=>  Padding(
      padding: const EdgeInsets.all(16.0),
      child:Row(
          children: [
            InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  if(profileController.isCommunitySelected.value==true) {
                    profileController.isCommunitySelected.value = false;
                    profileController.isEventSelected.value = true;
                    print("IsEventSelected: ${profileController.isEventSelected.value}");
                    print("IsCommunitySelected: ${profileController.isCommunitySelected.value}");
                  }
                },
                child: _buildTab('Communities',
                    profileController.isCommunitySelected.value)),
            InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  if(profileController.isEventSelected.value==true) {
                    profileController.isCommunitySelected.value = true;
                    profileController.isEventSelected.value = false;
                    print("IsEventSelected: ${profileController.isEventSelected.value}");
                    print("IsCommunitySelected: ${profileController.isCommunitySelected.value}");
                  }
                },
                child: _buildTab(
                    'Events', profileController.isEventSelected.value)),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              height: 2,
              width: 40,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }

  Widget _buildPosts() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildPostCard(
          name: 'Golden Gate Bridge',
          members: 14,
          privacy: 'Protected',
          imageUrl:
              'https://th.bing.com/th/id/OIP.QdzAAyOhdwk7IdWZCdM24AHaEn?rs=1&pid=ImgDetMain',
        ),
        _buildPostCard(
          name: 'San Francisco City Hall',
          members: 18,
          privacy: 'Public',
          imageUrl:
              'https://th.bing.com/th/id/OIP.1wtea--BJYoMuXFuWo__TQHaFj?rs=1&pid=ImgDetMain',
        ),
        _buildPostCard(
          imageUrl:
              'https://th.bing.com/th/id/OIP.odSm-Lqc9Au-acbkdUboowHaE-?rs=1&pid=ImgDetMain',
          name: 'Famous house on Lombard Street',
          members: 24,
          privacy: 'Private',
        ),
      ],
    );
  }

  Widget _buildEvent() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildPostCard(
          name: 'Becker Inc',
          members: 14,
          privacy: 'Catalina Foothills',
          imageUrl:
              'https://th.bing.com/th/id/OIP.QdzAAyOhdwk7IdWZCdM24AHaEn?rs=1&pid=ImgDetMain',
          dateTime: '2014-06-21T01:25:34.333Z'
        ),
        _buildPostCard(
          name: 'King - Will',
          members: 18,
          privacy: 'King - Will',
          imageUrl:
              'https://th.bing.com/th/id/OIP.1wtea--BJYoMuXFuWo__TQHaFj?rs=1&pid=ImgDetMain',
          dateTime: '2016-05-21T01:25:34.333Z'
        ),
        _buildPostCard(
          imageUrl:
              'https://th.bing.com/th/id/OIP.odSm-Lqc9Au-acbkdUboowHaE-?rs=1&pid=ImgDetMain',
          name: 'Williamson, Hagenes and King',
          members: 24,
          privacy: 'Lake Ridge',
          dateTime: '1993-10-31T10:36:04.610Z'
        ),
      ],
    );
  }

  Widget _buildPostCard({
    name,
    privacy,
    members,
    imageUrl,
    dateTime,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          members.toString(),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        Text(
          privacy,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
