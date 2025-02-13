import 'package:events/features/Events/presentation/create_event_screen.dart';
import 'package:events/shared/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'EventDetailsScreen.dart';

class Event {
  final String title, venue, dateTime, image;
  Event(
      {required this.title,
      required this.venue,
      required this.dateTime,
      required this.image});
}

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  String _selectedFilter = "All events";
  final Set<String> _selectedCategories = {};
  final TextEditingController _searchController = TextEditingController();
  bool categoryVisible = true;
  bool filterVisible = true;
  String selectedDate = DateFormat('MMM dd, yyyy').format(DateTime.now());
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

  final List<Event> _allEvents = [
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
      image:
          "https://cdn.slidesharecdn.com/ss_thumbnails/introductiontodatascience-181119212838-thumbnail-4.jpg?cb=1542663015",
    ),
    Event(
      title: "Product Management Career Tips",
      venue: "Zoom Online Event",
      dateTime: "Fri, Dec 30, 10:00 AM",
      image:
          "https://th.bing.com/th/id/OIP.e4OfTovxUE2xDKDOW5nNQwHaEK?rs=1&pid=ImgDetMain",
    ),
  ];

  List<Event> get _filteredEvents {
    return _allEvents.where((event) {
      if (_selectedFilter != "All events") {
        // Example filtering logic (Modify based on actual data)
        if (_selectedFilter == "Today" &&
            !selectedDate.contains(DateFormat("MMM dd").format(DateTime.now())))
          return false;
        if (_selectedFilter == "Tomorrow" &&
            !selectedDate.contains(DateFormat("MMM dd")
                .format(DateTime.now().add(Duration(days: 1))))) return false;
        if (_selectedFilter == "This week" &&
            !selectedDate.contains(DateFormat("MMM").format(DateTime.now())))
          return false;
      }
      if (_selectedCategories.isNotEmpty) {
        return _selectedCategories
            .any((category) => event.title.contains(category));
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading:false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Events',
              style: TextStyle(
                  color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            IconButton(onPressed: (){
              Get.to(CreateEventScreen());
            }, icon: Icon(Icons.add,color: Colors.black,))
          ],
        ),
      ),
      bottomNavigationBar: bottomnavigationbar(selectedIndex: 2),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔎 Search Bar
          Padding(
            padding: const EdgeInsets.all(10),
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
              onChanged: (value) => setState(() {}),
            ),
          ),

          // 🔍 Filters
          _buildSectionHeader("Filters", () {
            setState(() => filterVisible = !filterVisible);
          }),
          _buildFilterChips(),

          // 🏷 Categories
          _buildSectionHeader("Categories", () {
            setState(() => categoryVisible = !categoryVisible);
          }),
          _buildCategoryChips(),

          // 🎫 Events List
          Expanded(
            child: _filteredEvents.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredEvents.length,
                    itemBuilder: (context, index) =>
                        _buildEventCard(_filteredEvents[index]),
                  )
                : const Center(child: Text("No events found")),
          ),
        ],
      ),
    );
  }

  // 🔍 Section Header
  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Row(
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Spacer(),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.filter_list, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  // 🔎 Filters
  Widget _buildFilterChips() {
    return filterVisible
        ? SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children:
                  _filters.map((filter) => _buildFilterChip(filter)).toList(),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildFilterChip(String filter) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(filter),
        selected: _selectedFilter == filter,
        onSelected: (selected) => setState(() => _selectedFilter = filter),
        backgroundColor: Colors.grey[100],
        selectedColor: Colors.blue[100],
        labelStyle: TextStyle(
            color: _selectedFilter == filter ? Colors.blue : Colors.black),
      ),
    );
  }

  // 🏷 Categories
  Widget _buildCategoryChips() {
    return categoryVisible
        ? SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _categories
                  .map((category) => _buildCategoryChip(category))
                  .toList(),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildCategoryChip(String category) {
    bool isSelected = _selectedCategories.contains(category);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (selected) => setState(() {
          selected
              ? _selectedCategories.add(category)
              : _selectedCategories.remove(category);
        }),
        backgroundColor: Colors.grey[100],
        selectedColor: Colors.blue[100],
        labelStyle: TextStyle(color: isSelected ? Colors.blue : Colors.black),
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
            child: Image.network(event.image,
                height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(event.venue,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey)),
                          Text(event.dateTime,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(
                            () => EventDetailsScreen(),
                            arguments: {
                              'title': event.title,
                              'venue': event.venue,
                              'dateTime': event.dateTime,
                              'image': event.image,
                            },
                          );
                        },
                        child: const Text('Details'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
