import 'package:flutter/material.dart';

import '../models/EventModel.dart';

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

  final List<String> _filters = [
    "All events",
    "Today",
    "Tomorrow",
    "This week"
  ];

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
      title: "How to become a millionaire in 2023",
      venue: "The Westin St. Francis San Francisco on Union Square",
      dateTime: "Tue, Dec 27, 6:00 PM",
      image: "assets/event1.jpg",
    ),
    Event(
      title: "Introduction to Data Science",
      venue: "UC Berkeley Extension",
      dateTime: "Thu, Dec 29, 2:00 PM",
      image: "assets/event2.jpg",
    ),
    Event(
      title: "Product Management Career Tips",
      venue: "Zoom online event",
      dateTime: "Fri, Dec 30, 10:00 AM",
      image: "assets/event3.jpg",
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
          // Search Bar
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

          // Tabs
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

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Filters',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Filters
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _filters.map((filter) => _buildFilterChip(filter)).toList(),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _categories.map((category) => _buildCategoryChip(category)).toList(),
            ),
          ),

          // Events List
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

  Widget _buildCategoryChip(String category) {
    bool isSelected = _selectedCategories.contains(category);
    return FilterChip(
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
    );
  }

  Widget _buildEventCard(Event event) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              event.image,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.venue,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.dateTime,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

