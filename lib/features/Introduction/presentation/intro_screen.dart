import 'package:events/features/auth/presentation/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/IntroModel.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<IntroContent> _contents = [
    IntroContent(
      image: 'https://thumbs.dreamstime.com/z/vector-illustration-community-consisting-young-people-colorful-depicts-cute-multi-nationalities-add-separate-176377060.jpg', // You'll need to add this asset
      title: 'Pick every product that you want!',
      description: 'Determine your financial planning. Everything is right on track, no problem, guys!',
    ),
    IntroContent(
      image: 'https://img.freepik.com/free-vector/events-concept-illustration_114360-7733.jpg', // You'll need to add this asset
      title: 'Pick every product that you want!',
      description: 'Determine your financial planning. Everything is right on track, no problem, guys!',
    ),
    // Add more intro contents here
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _contents.length,
                itemBuilder: (context, index) {
                  return _buildPage(_contents[index]);
                },
              ),
            ),
            _buildPaginationDots(),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(IntroContent content) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            content.image,
            height: 300,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  content.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  content.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationDots() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _contents.length,
              (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index
                  ? Colors.blue
                  : Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          if (_currentPage == _contents.length - 1) {
            // Navigate to main app
            Get.to(FandomOnboarding());
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Next feature',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

