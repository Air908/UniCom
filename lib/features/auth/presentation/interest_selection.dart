import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/features/auth/models/interest_selection_model.dart';
import 'package:events/features/dashboard/presentation/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final Set<String> selectedInterests = {};
  final categories = InterestModel().categories;
  bool _isLoading = false;

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

  Future<void> handleNext() async {
    if (!canProceed) return;

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not authenticated');

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'interests': selectedInterests.toList(),
        'last_updated': FieldValue.serverTimestamp(),
      });

      _showSuccessMessage('Interests updated successfully!');
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      _showErrorMessage('Failed to update interests: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _handleSkip() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Skip Interest Selection?'),
        content: const Text('You can always update your interests later from your profile.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Get.offAll(() => const HomeScreen());
            },
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(MapEntry<String, List<String>> category) {
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
          children: category.value.map((interest) => _buildInterestChip(interest)).toList(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildInterestChip(String interest) {
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
      selectedColor: Theme.of(context).primaryColor,
      checkmarkColor: Colors.white,
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
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
            onPressed: _handleSkip,
            child: const Text(
              'Skip',
              style: TextStyle(fontSize: 16),
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
                    ...categories.entries.map(_buildCategorySection),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : (canProceed ? handleNext : null),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    disabledBackgroundColor: Colors.grey[300],
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
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