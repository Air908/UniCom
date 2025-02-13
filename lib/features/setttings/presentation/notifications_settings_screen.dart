import 'package:flutter/material.dart';

class NotificationsSettingsScreen extends StatelessWidget {
  const NotificationsSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Privacy Settings'),
          const SizedBox(height: 16),
          _buildPrivacyOption(
            'Who can see your profile?',
            'Everyone',
          ),
          _buildPrivacyOption(
            'Who can send you messages?',
            'Everyone',
          ),
          _buildPrivacyOption(
            'Who can send you email notifications?',
            'Everyone',
          ),
          const SizedBox(height: 32),
          _buildSectionTitle('Blocking'),
          const SizedBox(height: 16),
          _buildNavigationOption('Blocked users'),
          const SizedBox(height: 32),
          _buildSectionTitle('Report an issue'),
          const SizedBox(height: 16),
          _buildNavigationOption('Report a bug'),
          _buildNavigationOption('Report abuse'),
          _buildNavigationOption('Send feedback'),
          const SizedBox(height: 32),
          _buildSectionTitle('Admin tools'),
          const SizedBox(height: 16),
          _buildNavigationOption('Moderation log'),
          _buildNavigationOption('Community settings'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildPrivacyOption(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationOption(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
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
          const Icon(
            Icons.chevron_right,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}