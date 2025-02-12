import '../../discussion/presentation/discussion_screen.dart';



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

class HomeScreenModel{


  final List<Post> posts = [
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

}