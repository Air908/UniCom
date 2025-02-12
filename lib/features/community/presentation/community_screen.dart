import 'package:events/features/community/presentation/new_community_screen.dart';
import 'package:flutter/material.dart';

// Model for Community
class Community {
  final String id;
  final String name;
  final String description;
  final String privacy;
  final int members;
  final String imageUrl;

  Community({
    required this.id,
    required this.name,
    required this.description,
    required this.privacy,
    required this.members,
    this.imageUrl = '',
  });
}

class CommunitiesListScreen extends StatefulWidget {
  const CommunitiesListScreen({Key? key}) : super(key: key);

  @override
  _CommunitiesListScreenState createState() => _CommunitiesListScreenState();
}

class _CommunitiesListScreenState extends State<CommunitiesListScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Community> _communities = [];
  List<Community> _filteredCommunities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCommunities();
    _searchController.addListener(_filterCommunities);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Simulated API call to load communities
  Future<void> _loadCommunities() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Sample data
    final List<Community> communities = [
      Community(
        id: '1',
        name: 'Flutter Developers',
        description: 'A community for Flutter enthusiasts',
        privacy: 'Public',
        members: 1200,
      ),
      Community(
        id: '2',
        name: 'Mobile App Design',
        description: 'Share and discuss mobile app designs',
        privacy: 'Public',
        members: 850,
      ),
      Community(
        id: '3',
        name: 'UI/UX Discussion',
        description: 'Everything about UI/UX design',
        privacy: 'Private',
        members: 650,
      ),
      // Add more sample communities as needed
    ];

    setState(() {
      _communities = communities;
      _filteredCommunities = communities;
      _isLoading = false;
    });
  }

  void _filterCommunities() {
    final String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCommunities = _communities.where((community) {
        return community.name.toLowerCase().contains(query) ||
            community.description.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _navigateToCreateCommunity() {
    // Navigate to create community screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateCommunityScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Communities',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.blue),
            onPressed: _navigateToCreateCommunity,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search communities...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredCommunities.isEmpty
                ? const Center(
              child: Text(
                'No communities found',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
                : RefreshIndicator(
              onRefresh: _loadCommunities,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filteredCommunities.length,
                itemBuilder: (context, index) {
                  final community = _filteredCommunities[index];
                  return CommunityCard(community: community);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CommunityCard extends StatelessWidget {
  final Community community;

  const CommunityCard({
    Key? key,
    required this.community,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to community details
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: community.imageUrl.isEmpty
                    ? Center(
                  child: Text(
                    community.name[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    community.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      community.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          community.privacy == 'Public'
                              ? Icons.public
                              : Icons.lock,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          community.privacy,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.people,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${community.members.toString()} members',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
