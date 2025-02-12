
// Message Model
class ChatMessage {
  final String text;
  final String sender;
  final DateTime timestamp;
  final bool isMe;

  ChatMessage({
    required this.text,
    required this.sender,
    required this.timestamp,
    required this.isMe,
  });
}