import 'package:flutter/material.dart';

enum SearchFilter { all, users, communities, posts, events }

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchFilter selectedFilter = SearchFilter.all;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  bool isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void performSearch(String query) {
    setState(() {
      isLoading = true;
    });

    // Simulate API call with delayed response
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        // Here you would normally make an API call and filter based on selectedFilter
        searchResults = getDummyResults(query, selectedFilter);
        isLoading = false;
      });
    });
  }

  List<dynamic> getDummyResults(String query, SearchFilter filter) {
    // Dummy data - replace with actual API call
    switch (filter) {
      case SearchFilter.users:
        return ['User 1', 'User 2', 'User 3'].where(
                (user) => user.toLowerCase().contains(query.toLowerCase())).toList();
      case SearchFilter.communities:
        return ['Community 1', 'Community 2'].where((community) =>
            community.toLowerCase().contains(query.toLowerCase())).toList();
      case SearchFilter.posts:
        return ['Post 1', 'Post 2', 'Post 3', 'Post 4'].where(
                (post) => post.toLowerCase().contains(query.toLowerCase())).toList();
      case SearchFilter.events:
        return ['Event 1', 'Event 2'].where(
                (event) => event.toLowerCase().contains(query.toLowerCase())).toList();
      case SearchFilter.all:
        return [...getDummyResults(query, SearchFilter.users),
          ...getDummyResults(query, SearchFilter.communities),
          ...getDummyResults(query, SearchFilter.posts),
          ...getDummyResults(query, SearchFilter.events)];
    }
  }

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
          'Search',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              onChanged: performSearch,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: SearchFilter.values.map((filter) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      filter.name[0].toUpperCase() + filter.name.substring(1),
                      style: TextStyle(
                        color: selectedFilter == filter
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                    selected: selectedFilter == filter,
                    onSelected: (selected) {
                      setState(() {
                        selectedFilter = filter;
                        performSearch(_searchController.text);
                      });
                    },
                    backgroundColor: Colors.grey[100],
                    selectedColor: Colors.blue.withOpacity(0.1),
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index].toString()),
                  onTap: () {
                    // Handle item tap
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}