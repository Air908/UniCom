import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              _buildProfileSection(),
              const SizedBox(height: 32),
              const Text(
                'Application preferences',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              _buildPreferencesSection(),
              const SizedBox(height: 32),
              const Text(
                'Support',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              _buildSupportSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        _buildSettingsItem(
          'Name',
          'Alice',
          onTap: () {},
        ),
        _buildSettingsItem(
          'Username',
          '@alice',
          onTap: () {},
        ),
        _buildSettingsItem(
          'Email',
          'example@gmail.com',
          onTap: () {},
        ),
        _buildSettingsItem(
          'Password',
          '',
          showArrow: true,
          onTap: () {},
        ),
        _buildSettingsItem(
          'Notifications',
          '',
          showArrow: true,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildPreferencesSection() {
    return Column(
      children: [
        _buildSettingsItem(
          'Language',
          'English',
          onTap: () {},
        ),
        _buildSettingsItem(
          'Theme',
          isDarkMode ? 'Dark mode' : 'Light mode',
          onTap: () {
            setState(() {
              isDarkMode = !isDarkMode;
            });
          },
        ),
        _buildSettingsItem(
          'Data usage',
          '',
          showArrow: true,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return Column(
      children: [
        _buildSettingsItem(
          'I need help',
          '',
          showArrow: true,
          onTap: () {},
        ),
        _buildSettingsItem(
          'I have a safety concern',
          '',
          showArrow: true,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSettingsItem(
      String title,
      String value, {
        bool showArrow = false,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Row(
              children: [
                if (value.isNotEmpty)
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                if (showArrow)
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.black54,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}