import 'package:cached_network_image/cached_network_image.dart';
import 'package:events/features/auth/controller/email_signin.dart';
import 'package:events/features/auth/controller/google_auth.dart';
import 'package:events/features/auth/presentation/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'interest_selection.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CarouselSliderController?  controller = CarouselSliderController();
  int activeIndex = 0;

  final List<String> titles = [
    "Join the world's largest\nfan community",
    "Connect with fellow fans\naround the globe",
    "Share your passion with\nothers like you"
  ];

  final List<String> images = [
    "https://img.freepik.com/premium-photo/large-group-people-shape-man-with-trumpet-isolated_267651-2146.jpg?w=826",
    "https://img.freepik.com/free-vector/business-people-with-map-world_1308-31683.jpg?t=st=1739942850~exp=1739946450~hmac=3cbbf1bad7f275e5642d09c020e5c68307d84de84e4300d95dafd12bd1159f6c&w=826",
    "https://img.freepik.com/free-vector/flat-young-people-social-media-like-concept-background_23-2148109831.jpg?t=st=1739942947~exp=1739946547~hmac=81cbf47b0d7e8acba66b19eb28688299b546fb740448a865c2b17ab1ecdde889&w=826"
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
                            CachedNetworkImage(
                              imageUrl: images[index],
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.broken_image),
                              fit: BoxFit.cover,
                              width: double.infinity,
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
              googleAuth().isLoading ? CircularProgressIndicator(): _buildContinueButton(
                'Continue with Google',
                onPressed: () async {
                  setState(() {
                    googleAuth().isLoading = true;  // Start loading
                  });

                  final userCredential = await googleAuth().signInWithGoogle();

                  setState(() {
                    googleAuth().isLoading = false;  // Stop loading
                  });

                  if (userCredential != null) {
                    // Successfully signed in, handle the user data
                    print('Signed in as: ${userCredential.user?.displayName}');
                    // Navigate to next screen or do something with the signed-in user data
                    Get.to(RegisterScreen());
                  } else {
                    // Handle the error or cancellation
                    print('Sign-in failed or cancelled');
                    // Show error message to the user
                  }
                },
              ),
              const SizedBox(height: 12),
              _buildContinueButton(
                'Continue with email',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return EmailSignInDialog();
                    },
                  );
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