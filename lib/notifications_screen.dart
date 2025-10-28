import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  final List<Map<String, dynamic>> notifications = const [
    {
      'event': 'Left Home Zone',
      'time': '8:10 AM',
      'details': 'Location: 500m from home',
      'isRead': false,
      'type': 'movement'
    },
    {
      'event': 'Entered School Zone',
      'time': '8:35 AM',
      'details': 'Location: University of Batangas',
      'isRead': true,
      'type': 'safe'
    },
    {
      'event': 'Left School Zone',
      'time': '3:42 PM',
      'details': 'Location: 200m from school',
      'isRead': false,
      'type': 'alert'
    },
    {
      'event': 'Entered Home Zone',
      'time': '4:10 PM',
      'details': 'Location: Home',
      'isRead': true,
      'type': 'safe'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final accentColor = const Color(0xFFFFC553);
    final primaryColor = const Color(0xFF862334);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          children: [
            // Logo on the left
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                'asset/UBlogo.png', // Your logo path
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) => 
                    const Icon(Icons.error_outline, color: Colors.white),
              ),
            ),
            // Centered title
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  'Notifications',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // Invisible placeholder to balance the logo
            const SizedBox(width: 40), // Matches logo width + padding
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.done_all),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All notifications marked as read')),
                );
              },
              tooltip: 'Mark all as read',
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip('All', true, primaryColor),
                const SizedBox(width: 8),
                _buildFilterChip('Alerts', false, Colors.red),
                const SizedBox(width: 8),
                _buildFilterChip('Safe', false, Colors.green),
                const SizedBox(width: 8),
                _buildFilterChip('Movement', false, Colors.blue),
              ],
            ),
          ),
          // Notifications list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                Color notifColor;
                IconData notifIcon;

                switch (notification['type']) {
                  case 'alert':
                    notifColor = Colors.red;
                    notifIcon = Icons.warning_rounded;
                    break;
                  case 'safe':
                    notifColor = Colors.green;
                    notifIcon = Icons.check_circle;
                    break;
                  case 'movement':
                    notifColor = Colors.blue;
                    notifIcon = Icons.directions_walk;
                    break;
                  default:
                    notifColor = Colors.grey;
                    notifIcon = Icons.info;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: notification['isRead']
                        ? null
                        : Border.all(color: notifColor.withOpacity(0.5)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: notifColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(notifIcon, color: notifColor),
                    ),
                    title: Text(
                      notification['event'],
                      style: TextStyle(
                        fontWeight: notification['isRead']
                            ? FontWeight.normal
                            : FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(notification['details'],
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification['time'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        notification['isRead']
                            ? Icons.more_vert
                            : Icons.check_circle_outline,
                        color: notification['isRead']
                            ? Colors.grey
                            : primaryColor,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              notification['isRead']
                                  ? 'Notification options'
                                  : 'Marked \"${notification['event']}\" as read',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Refreshing notifications...')),
          );
        },
        backgroundColor: accentColor,
        child: const Icon(Icons.refresh, color: Colors.black87),
        tooltip: 'Refresh notifications',
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, Color color) {
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedColor: color,
      backgroundColor: Colors.white,
      checkmarkColor: Colors.white,
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      onSelected: (bool selected) {},
    );
  }
}