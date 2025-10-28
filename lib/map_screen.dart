import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF862334);
    final accentColor = const Color(0xFFFFC553);

    return Scaffold(
      appBar: AppBar(
  title: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [

      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Image.asset(
          'asset/UBlogo.png',
          width: 50,
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
      // Centered text
      Expanded(
        child: Container(
          alignment: Alignment.center,
          child: const Text(
            'Live Location',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  actions: [
    IconButton(
      icon: const Icon(Icons.refresh),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Refreshing location data...')),
        );
      },
      tooltip: 'Refresh map',
    ),
    IconButton(
      icon: const Icon(Icons.layers),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Map Layers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Icon(Icons.map, color: primaryColor),
                  title: const Text('Default Map'),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: Icon(Icons.satellite, color: primaryColor),
                  title: const Text('Satellite View'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: Icon(Icons.directions, color: primaryColor),
                  title: const Text('Traffic View'),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
      tooltip: 'Map layers',
    ),
  ],
),
      body: Stack(
        children: [
          // Map placeholder
          Container(
            color: Colors.grey[300],
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: Text(
                'FAKE MAP IMAGE\n(Static Placeholder)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black45),
              ),
            ),
          ),
          // Location markers
          const Positioned(
            left: 80,
            top: 180,
            child: MapMarker(
              label: 'Home',
              color: Colors.blue,
              icon: Icons.home,
            ),
          ),
          const Positioned(
            right: 80,
            bottom: 150,
            child: MapMarker(
              label: 'School',
              color: Colors.green,
              icon: Icons.school,
            ),
          ),
          const Positioned(
            left: 200,
            top: 300,
            child: MapMarker(
              label: 'Lance',
              color: Colors.red,
              icon: Icons.person_pin_circle,
              isChild: true,
              lastUpdate: '3:42 PM',
            ),
          ),
          // Control panel
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Lance Lenard Panopio',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: primaryColor),
                        const SizedBox(width: 4),
                        const Text(
                          'University of Batangas area',
                          style: TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            '3:42 PM',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Opening directions...'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.directions),
                          label: const Text('Directions'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryColor,
                            side: BorderSide(color: primaryColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Location history viewed'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.history),
                            label: const Text('View History'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor,
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Map control buttons
          Positioned(
            top: 16,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  foregroundColor: primaryColor,
                  heroTag: "zoom_in",
                  child: const Icon(Icons.add),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Zooming in...')),
                    );
                  },
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  foregroundColor: primaryColor,
                  heroTag: "zoom_out",
                  child: const Icon(Icons.remove),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Zooming out...')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MapMarker extends StatelessWidget {
  const MapMarker({
    super.key,
    required this.label,
    required this.color,
    required this.icon,
    this.isChild = false,
    this.lastUpdate,
  });

  final String label;
  final Color color;
  final IconData icon;
  final bool isChild;
  final String? lastUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, size: 24, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (isChild && lastUpdate != null) ...[
          const SizedBox(height: 4),
          Text(
            'Last updated: $lastUpdate',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }
}