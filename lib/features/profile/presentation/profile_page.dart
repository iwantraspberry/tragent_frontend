import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/services/auth_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings feature coming soon!')),
              );
            },
          ),
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.user;
          
          if (user == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: [
                _buildProfileHeader(user, context),
                const SizedBox(height: 32),
                _buildProfileStats(),
                const SizedBox(height: 32),
                _buildMenuSection(context, authProvider),
                const SizedBox(height: 32),
                _buildAccountSection(context, authProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(user, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppConstants.defaultBorderRadius),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: user.avatar != null
                ? ClipOval(
                    child: Image.network(
                      user.avatar!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Text(
                          user.name.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        );
                      },
                    ),
                  )
                : Text(
                    user.name.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            user.email,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to edit profile
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit profile feature coming soon!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.primaryColor,
            ),
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStats() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('5', 'Trips Planned', Icons.map)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('12', 'Countries', Icons.public)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('28', 'Cities', Icons.location_city)),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: AppTheme.primaryColor),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, AuthProvider authProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Travel Management',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildMenuItem(
          icon: Icons.flight_takeoff,
          title: 'My Trips',
          subtitle: 'View and manage your travel plans',
          onTap: () {
            // TODO: Navigate to trips
          },
        ),
        _buildMenuItem(
          icon: Icons.favorite,
          title: 'Favorites',
          subtitle: 'Your saved destinations and activities',
          onTap: () {
            // TODO: Navigate to favorites
          },
        ),
        _buildMenuItem(
          icon: Icons.history,
          title: 'Travel History',
          subtitle: 'Past trips and experiences',
          onTap: () {
            // TODO: Navigate to history
          },
        ),
        _buildMenuItem(
          icon: Icons.receipt_long,
          title: 'Booking History',
          subtitle: 'View your bookings and reservations',
          onTap: () {
            // TODO: Navigate to bookings
          },
        ),
      ],
    );
  }

  Widget _buildAccountSection(BuildContext context, AuthProvider authProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Account',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildMenuItem(
          icon: Icons.notifications,
          title: 'Notifications',
          subtitle: 'Manage your notification preferences',
          onTap: () {
            // TODO: Navigate to notifications settings
          },
        ),
        _buildMenuItem(
          icon: Icons.security,
          title: 'Privacy & Security',
          subtitle: 'Manage your account security',
          onTap: () {
            // TODO: Navigate to security settings
          },
        ),
        _buildMenuItem(
          icon: Icons.language,
          title: 'Language & Region',
          subtitle: 'Change app language and currency',
          onTap: () {
            // TODO: Navigate to language settings
          },
        ),
        _buildMenuItem(
          icon: Icons.help,
          title: 'Help & Support',
          subtitle: 'Get help and contact support',
          onTap: () {
            // TODO: Navigate to help
          },
        ),
        _buildMenuItem(
          icon: Icons.info,
          title: 'About',
          subtitle: 'App version and information',
          onTap: () {
            _showAboutDialog(context);
          },
        ),
        const SizedBox(height: 24),
        _buildMenuItem(
          icon: Icons.logout,
          title: 'Sign Out',
          subtitle: 'Sign out of your account',
          isDestructive: true,
          onTap: () => _showLogoutDialog(context, authProvider),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? AppTheme.errorColor : AppTheme.primaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isDestructive ? AppTheme.errorColor : null,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppConstants.appName,
      applicationVersion: AppConstants.appVersion,
      applicationIcon: const Icon(
        Icons.travel_explore,
        size: 48,
        color: AppTheme.primaryColor,
      ),
      children: const [
        Text(
          'Your intelligent travel planning companion. Discover amazing destinations, plan perfect trips, and create unforgettable memories.',
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await authProvider.logout();
              if (context.mounted) {
                context.go(AppConstants.loginRoute);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
