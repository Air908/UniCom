// netflix_discussion_screen.dart
import 'package:flutter/material.dart';

class NetflixDiscussionScreen extends StatefulWidget {
  const NetflixDiscussionScreen({Key? key}) : super(key: key);

  @override
  State<NetflixDiscussionScreen> createState() => _NetflixDiscussionScreenState();
}

class _NetflixDiscussionScreenState extends State<NetflixDiscussionScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Hot', 'New', 'Top', 'Controversial'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('r/Netflix'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_downward),
            onPressed: () {
              // Implement dropdown functionality
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((String tab) => Tab(text: tab)).toList(),
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
        ),
      ),
      body: ListView(
        children: [
          _buildPost(),
          _buildReplySection(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          // Implement new post functionality
        },
      ),
    );
  }

  Widget _buildPost() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage('https://placeholder.com/user1'),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What are some good shows to watch?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'u/loveschocolat',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "I've been watching a lot of TV lately and I'm running out of shows to watch. Any recommendations?",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildActionButton(Icons.arrow_upward, '10'),
              _buildActionButton(Icons.arrow_downward, '2'),
              _buildActionButton(Icons.comment, '32'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String count) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 4),
          Text(count, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildReplySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://placeholder.com/user2'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Add your reply',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
