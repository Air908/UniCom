import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/EventModel.dart'; // Ensure EventModel is correctly implemented

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  String _selectedTab = "For you";
  String _selectedFilter = "All events";
  final Set<String> _selectedCategories = {};
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = ["All events", "Today", "Tomorrow", "This week"];
  final List<String> _categories = [
    "Career & Business",
    "Tech",
    "Health",
    "Science",
    "Food & Drink",
    "Music",
    "Sports & Fitness",
    "Other"
  ];

  final List<Event> _events = [
    Event(
      title: "How to Become a Millionaire in 2023",
      venue: "The Westin St. Francis, SF",
      dateTime: "Tue, Dec 27, 6:00 PM",
      image: "https://i.ytimg.com/vi/Bv5K6I2DQTM/maxresdefault.jpg",
    ),
    Event(
      title: "Introduction to Data Science",
      venue: "UC Berkeley Extension",
      dateTime: "Thu, Dec 29, 2:00 PM",
      image: "https://cdn.slidesharecdn.com/ss_thumbnails/introductiontodatascience-181119212838-thumbnail-4.jpg?cb=1542663015",
    ),
    Event(
      title: "Product Management Career Tips",
      venue: "Zoom Online Event",
      dateTime: "Fri, Dec 30, 10:00 AM",
      image: "https://th.bing.com/th/id/OIP.e4OfTovxUE2xDKDOW5nNQwHaEK?rs=1&pid=ImgDetMain",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Events',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔎 Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for events',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📌 Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildTab("For you"),
                const SizedBox(width: 24),
                _buildTab("Popular"),
                const SizedBox(width: 24),
                _buildTab("Suggested"),
              ],
            ),
          ),

          // 🔍 Filters
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Filters',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _filters.map((filter) => _buildFilterChip(filter)).toList(),
            ),
          ),

          // 🏷 Categories
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _categories.map((category) => _buildCategoryChip(category)).toList(),
            ),
          ),

          // 🎫 Events List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _events.length,
              itemBuilder: (context, index) => _buildEventCard(_events[index]),
            ),
          ),
        ],
      ),
    );
  }

  // 🌟 Tab Selection
  Widget _buildTab(String title) {
    bool isSelected = _selectedTab == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = title;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          if (isSelected)
            Container(
              height: 2,
              width: 40,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }

  // 🔎 Filters
  Widget _buildFilterChip(String filter) {
    bool isSelected = _selectedFilter == filter;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(filter),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            _selectedFilter = filter;
          });
        },
        backgroundColor: Colors.grey[100],
        selectedColor: Colors.blue[100],
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
    );
  }

  // 🏷 Categories
  Widget _buildCategoryChip(String category) {
    bool isSelected = _selectedCategories.contains(category);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedCategories.add(category);
            } else {
              _selectedCategories.remove(category);
            }
          });
        },
        backgroundColor: Colors.grey[100],
        selectedColor: Colors.blue[100],
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue : Colors.black,
        ),
      ),
    );
  }

  // 🎫 Event Cards
  Widget _buildEventCard(Event event) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(event.image, height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(event.venue, style: TextStyle(fontSize: 16, color: Colors.blue[700])),
                const SizedBox(height: 4),
                Text(event.dateTime, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
