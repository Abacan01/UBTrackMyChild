import 'package:flutter/material.dart';

class SafeZonesScreen extends StatefulWidget {
  const SafeZonesScreen({super.key});

  @override
  State<SafeZonesScreen> createState() => _SafeZonesScreenState();
}

class _SafeZonesScreenState extends State<SafeZonesScreen> {
  List<Map<String, dynamic>> safeZones = [
    {
      'name': 'Home',
      'address': '123 Main St, Batangas City',
      'radius': 150,
      'color': Colors.blue,
      'icon': Icons.home,
    },
    {
      'name': 'School',
      'address': 'University of Batangas',
      'radius': 300,
      'color': Colors.green,
      'icon': Icons.school,
    },
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  double _radius = 200;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'asset/UBlogo.png',
              width: 50, // Adjust size as needed
              height: 50,
            ),
          ),
            Expanded(
        child: Container(
          alignment: Alignment.center,
          child: const Text(
            'Safe Zones',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add_location, size: 24),
          ),
          tooltip: 'Add Safe Zone',
          onPressed: () => _showAddSafeZoneDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: safeZones.length,
        itemBuilder: (context, index) {
          final zone = safeZones[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: (zone['color'] as Color).withOpacity(0.15),
                  child: Icon(zone['icon'] as IconData, color: zone['color'] as Color),
                ),
                title: Text(
                  zone['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(zone['address']),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 10, color: zone['color'] as Color),
                        const SizedBox(width: 6),
                        Text('Radius: ${zone['radius']} m', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.grey),
                  tooltip: 'Edit Safe Zone',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Edit ${zone['name']} feature coming soon!')),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddSafeZoneDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add New Safe Zone'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Zone Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: _radius,
                    min: 50,
                    max: 500,
                    divisions: 9,
                    label: '${_radius.round()}m',
                    onChanged: (value) {
                      setState(() {
                        _radius = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                onPressed: () {
                  if (_nameController.text.isEmpty || _addressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all fields')),
                    );
                    return;
                  }
                  _addSafeZone();
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _addSafeZone() {
    setState(() {
      safeZones.add({
        'name': _nameController.text,
        'address': _addressController.text,
        'radius': _radius.round(),
        'color': Colors.primaries[safeZones.length % Colors.primaries.length],
        'icon': Icons.pin_drop,
      });
    });
    
    _nameController.clear();
    _addressController.clear();
    _radius = 200;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Safe Zone added!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}