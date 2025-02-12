// penny_stocks_screen.dart
import 'package:flutter/material.dart';

class StockPost {
  final String title;
  final String time;
  final String avatarUrl;

  StockPost({
    required this.title,
    required this.time,
    required this.avatarUrl,
  });
}

class PennyStocksScreen extends StatefulWidget {
  const PennyStocksScreen({Key? key}) : super(key: key);

  @override
  State<PennyStocksScreen> createState() => _PennyStocksScreenState();
}

class _PennyStocksScreenState extends State<PennyStocksScreen> {
  final List<StockPost> posts = [
    StockPost(
      title: 'Stocks to Watch',
      time: '2:30 PM',
      avatarUrl: 'https://placekitten.com/100/100',
    ),
    StockPost(
      title: 'Aurora Cannabis Inc.',
      time: '2:31 PM',
      avatarUrl: 'https://placekitten.com/101/101',
    ),
    StockPost(
      title: 'Boeing Co.',
      time: '2:32 PM',
      avatarUrl: 'https://placekitten.com/102/102',
    ),
    StockPost(
      title: 'Tesla Inc.',
      time: '2:33 PM',
      avatarUrl: 'https://placekitten.com/103/103',
    ),
    StockPost(
      title: 'NIO Inc.',
      time: '2:34 PM',
      avatarUrl: 'https://placekitten.com/104/104',
    ),
    StockPost(
      title: 'Apple Inc.',
      time: '2:35 PM',
      avatarUrl: 'https://placekitten.com/105/105',
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Penny Stocks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tv),
            onPressed: () {
              // Implement video/streaming functionality
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return _buildPostTile(post);
              },
            ),
          ),
          _buildMessageInput(),
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildPostTile(StockPost post) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(post.avatarUrl),
      ),
      title: Text(
        post.title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        post.time,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          top: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://placekitten.com/50/50'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Message #pennystocks',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {},
                    color: Colors.blue,
                  ),
                  IconButton(
                    icon: const Icon(Icons.link),
                    onPressed: () {},
                    color: Colors.blue,
                  ),
                  IconButton(
                    icon: const Icon(Icons.mic),
                    onPressed: () {},
                    color: Colors.blue,
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {},
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}