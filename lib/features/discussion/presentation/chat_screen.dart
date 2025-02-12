import 'package:flutter/material.dart';

import '../models/ChatModel.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "I'm coming over in 5 mins. Can you get the door?",
      sender: "Sara",
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isMe: false,
    ),
    ChatMessage(
      text: "Sure! I'll be here.",
      sender: "Liam",
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      isMe: true,
    ),
    ChatMessage(
      text: "K. See you soon!",
      sender: "Sara",
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      isMe: false,
    ),
    ChatMessage(
      text: "Can I borrow your blender for a week?",
      sender: "Sara",
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isMe: false,
    ),
  ];

  void _handleSubmitted(String text) {
    _messageController.clear();
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: text,
          sender: "Liam",
          timestamp: DateTime.now(),
          isMe: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final showDate = index == _messages.length - 1 ||
                    !_isSameDay(message.timestamp,
                        _messages[index + 1].timestamp);

                return Column(
                  children: [
                    if (showDate) _buildDateDivider(message.timestamp),
                    _MessageBubble(message: message),
                  ],
                );
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildDateDivider(DateTime timestamp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        _isToday(timestamp) ? 'Today' : 'Yesterday',
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(
          top: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Message',
                  border: InputBorder.none,
                ),
                onSubmitted: _handleSubmitted,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                if (_messageController.text.isNotEmpty) {
                  _handleSubmitted(_messageController.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return _isSameDay(date, now);
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const _MessageBubble({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment:
        message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMe) _buildAvatar(),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: message.isMe ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isMe ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (message.isMe) _buildAvatar(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 16,
      backgroundImage: AssetImage(
        message.isMe ? 'assets/liam.jpg' : 'assets/sara.jpg',
      ),
    );
  }
}