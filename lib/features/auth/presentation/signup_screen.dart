import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'interest_selection.dart';

class FandomOnboarding extends StatefulWidget {
  const FandomOnboarding({super.key});

  @override
  State<FandomOnboarding> createState() => _FandomOnboardingState();
}

class _FandomOnboardingState extends State<FandomOnboarding> {
  CarouselSliderController?  controller = CarouselSliderController();
  int activeIndex = 0;

  final List<String> titles = [
    "Join the world's largest\nfan community",
    "Connect with fellow fans\naround the globe",
    "Share your passion with\nothers like you"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 32),
              const Text(
                'UniCom',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider.builder(
                      carouselController: controller,
                      itemCount: titles.length,
                      itemBuilder: (context, index, realIndex) {
                        return Column(
                          children: [
                            Image.asset(
                              'lib/shared/assets/images/welcome.png',
                              height: 300,
                            ),
                            const SizedBox(height: 32),
                            Text(
                              titles[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                      options: CarouselOptions(
                        height: 400,
                        viewportFraction: 1,

                        onPageChanged: (index, reason) {
                          setState(() => activeIndex = index);
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: titles.length,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.blue,
                        dotColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              _buildContinueButton(
                'Continue with Google',
                onPressed: () {
                  controller!.nextPage();
                },
              ),
              const SizedBox(height: 12),
              _buildContinueButton(
                'Continue with Facebook',
                onPressed: () {
                  controller!.previousPage();
                },
              ),
              const SizedBox(height: 12),
              _buildContinueButton(
                'Continue with email',
                onPressed: () {
                  Get.to(InterestsScreen());
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(String text, {required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}