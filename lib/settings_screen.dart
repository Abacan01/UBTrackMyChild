import 'package:flutter/material.dart';
import 'login_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF862334);
    final accentColor = const Color(0xFFFFC553);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(Icons.person, color: primaryColor),
              title: const Text('Account'),
              subtitle: const Text('Manage your account information'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Account settings coming soon!')),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(Icons.notifications, color: accentColor),
              title: const Text('Notifications'),
              subtitle: const Text('Notification preferences'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notification settings coming soon!')),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(Icons.lock, color: Colors.grey),
              title: const Text('Privacy & Security'),
              subtitle: const Text('Manage privacy settings'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Privacy settings coming soon!')),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Icon(Icons.info, color: primaryColor),
              title: const Text('About'),
              subtitle: const Text('App version, developer info'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'UBsafestep',
                  applicationVersion: '1.0.0',
                  applicationIcon: Icon(Icons.location_on, color: primaryColor),
                  children: [
                    const SizedBox(height: 8),
                    const Text('Developed by Team Dragon.\nFor demo purposes only.'),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                 Navigator.of(context).pushAndRemoveUntil(
                 MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false, // This clears all routes
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out!')),
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('LOG OUT'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}