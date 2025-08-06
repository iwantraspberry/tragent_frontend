import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/services/auth_provider.dart';
import '../../../shared/models/travel_plan.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class TravelHomePage extends StatefulWidget {
  const TravelHomePage({super.key});

  @override
  State<TravelHomePage> createState() => _TravelHomePageState();
}

class _TravelHomePageState extends State<TravelHomePage> {
  final _searchController = TextEditingController();
  List<TravelDestination> _popularDestinations = [];
  List<TravelPlan> _recentPlans = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    // TODO: Load from API service
    setState(() {
      _popularDestinations = _getMockDestinations();
      _recentPlans = _getMockPlans();
    });
  }

  List<TravelDestination> _getMockDestinations() {
    return [
      const TravelDestination(
        id: '1',
        name: 'Tokyo',
        country: 'Japan',
        description:
            'A bustling metropolis with modern technology and ancient traditions.',
        imageUrl: null,
        rating: 4.8,
        tags: ['Culture', 'Technology', 'Food'],
        currency: 'JPY',
        timezone: 'Asia/Tokyo',
      ),
      const TravelDestination(
        id: '2',
        name: 'Paris',
        country: 'France',
        description: 'The city of love, art, and incredible cuisine.',
        imageUrl: null,
        rating: 4.7,
        tags: ['Romance', 'Art', 'History'],
        currency: 'EUR',
        timezone: 'Europe/Paris',
      ),
    ];
  }

  List<TravelPlan> _getMockPlans() {
    return [
      TravelPlan(
        id: '1',
        title: 'Tokyo Adventure',
        description: 'Explore the wonders of Japan\'s capital',
        destination: 'Tokyo, Japan',
        startDate: DateTime.now().add(const Duration(days: 30)),
        endDate: DateTime.now().add(const Duration(days: 37)),
        budget: 2500.0,
        status: 'draft',
        activities: [],
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Travel Planning'),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Map view feature coming soon!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Create new trip feature coming soon!'),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeSection(),
              const SizedBox(height: 24),
              _buildSearchSection(),
              const SizedBox(height: 32),
              _buildQuickActions(),
              const SizedBox(height: 32),
              _buildPopularDestinations(),
              const SizedBox(height: 32),
              _buildRecentPlans(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to new trip planning
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Trip planning feature coming soon!')),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        icon: const Icon(Icons.add),
        label: const Text('Plan Trip'),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final userName = authProvider.user?.name ?? 'Traveler';
        final isGuest = authProvider.isGuestMode;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(
              AppConstants.defaultBorderRadius,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isGuest) ...[
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Guest Mode',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => context.go('/login'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                      ),
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
              Text(
                isGuest
                    ? 'Plan Your Perfect Trip!'
                    : 'Ready to plan your next adventure, $userName?',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isGuest
                    ? 'Discover amazing destinations, create detailed itineraries, and get AI-powered travel recommendations!'
                    : 'Where would you like to go next?',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              if (isGuest) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.white70,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Sign in to save your plans and get personalized recommendations',
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchSection() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search destinations, activities...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.tune),
          onPressed: () {
            // TODO: Show search filters
          },
        ),
      ),
      onSubmitted: (query) {
        // TODO: Implement search
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Searching for: $query')));
      },
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.flight_takeoff,
                title: 'Book Flight',
                subtitle: 'Find the best deals',
                onTap: () {
                  // TODO: Navigate to flight booking
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                icon: Icons.hotel,
                title: 'Find Hotels',
                subtitle: 'Comfortable stays',
                onTap: () {
                  // TODO: Navigate to hotel booking
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: AppTheme.primaryColor),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppTheme.textSecondaryColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularDestinations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Destinations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to all destinations
              },
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _popularDestinations.length,
            itemBuilder: (context, index) {
              final destination = _popularDestinations[index];
              return _buildDestinationCard(destination);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationCard(TravelDestination destination) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        child: InkWell(
          onTap: () {
            // TODO: Navigate to destination details
          },
          borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppConstants.defaultBorderRadius),
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 40, color: Colors.grey),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        destination.country,
                        style: const TextStyle(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      if (destination.rating != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              destination.rating!.toStringAsFixed(1),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentPlans() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Plans',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to all plans
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_recentPlans.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'No travel plans yet. Start planning your first trip!',
                ),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _recentPlans.length,
            itemBuilder: (context, index) {
              final plan = _recentPlans[index];
              return _buildPlanCard(plan);
            },
          ),
      ],
    );
  }

  Widget _buildPlanCard(TravelPlan plan) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to plan details
        },
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      plan.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(plan.status),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      plan.status.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                plan.destination,
                style: const TextStyle(color: AppTheme.textSecondaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                '${plan.startDate.day}/${plan.startDate.month} - ${plan.endDate.day}/${plan.endDate.month}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return AppTheme.secondaryColor;
      case 'completed':
        return Colors.grey;
      case 'draft':
      default:
        return AppTheme.accentColor;
    }
  }
}
