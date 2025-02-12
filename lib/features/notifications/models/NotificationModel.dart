
class NotificationModel{
  final String avatar;
  final String message;
  final String timeAgo;
  final bool isNew;

  NotificationModel({
    required this.avatar,
    required this.message,
    required this.timeAgo,
    this.isNew = false,
  });
}