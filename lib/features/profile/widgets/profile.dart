import 'package:breathing_analysis_app/theme/palette.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile picture
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/svgs/profile_placeholder.png'),
          ),
          const SizedBox(height: 16),
          // Name
          Text(
            'Demo Pfa',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          // Email
          Text(
            'demo.pfa@example.com',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          // Some profile details
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.cake),
              title: Text('Birthday'),
              subtitle: Text('January 1, 2002'),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
              subtitle: Text('+216 23 456 789'),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Location'),
              subtitle: Text('North Urban Center, Tunis, Tunisia'),
            ),
          ),
          const SizedBox(height: 80),
          // Log out button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: Icon(Icons.logout),
              label: Text('Log Out'),
              onPressed: () {
                // TODO: Implement log out logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logged out')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.redColor,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}