import 'package:events/features/auth/models/interest_selection_model.dart';
import 'package:events/features/dashboard/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final Set<String> selectedInterests = {};

  var categories = InterestModel().categories;

  bool get canProceed => selectedInterests.length >= 3;

  void toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        selectedInterests.add(interest);
      }
    });
  }

  void handleNext() {
    if (canProceed) {
      // Here you would typically navigate to the next screen
      // or send the selected interests to your backend
      print('Selected interests: $selectedInterests');
      Get.offAll(HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Get.off(HomeScreen());
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose your interests',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Personalize your experience by picking 3 or more topics',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 32),
                    ...categories.entries.map((category) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.key,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: category.value.map((interest) {
                              final isSelected = selectedInterests.contains(interest);
                              return FilterChip(
                                label: Text(
                                  interest,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                selected: isSelected,
                                onSelected: (_) => toggleInterest(interest),
                                backgroundColor: Colors.grey[100],
                                selectedColor: Colors.blue,
                                checkmarkColor: Colors.white,
                                showCheckmark: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: canProceed ? handleNext : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBackgroundColor: Colors.grey[300],
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}