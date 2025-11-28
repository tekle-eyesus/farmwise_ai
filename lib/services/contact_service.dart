class ContactService {
  static Future<List<Map<String, dynamic>>> fetchContacts(
    String diseaseLabel,
    String cropName,
  ) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Hardcoded contacts List
      final List<Map<String, dynamic>> contacts = [
        {
          'id': '1',
          'name': 'Agricultural Extension Office',
          'type': 'phone',
          'value': '+251911234567',
          'description':
              'Government agricultural support for $cropName farmers',
          'region': 'Addis Ababa',
          'availability': 'Mon-Fri, 8:30 AM - 5:30 PM',
        },
        {
          'id': '2',
          'name': 'Crop Protection Specialist',
          'type': 'phone',
          'value': '+251922345678',
          'description':
              'Expert advice on $diseaseLabel treatment and prevention',
          'region': 'Oromia',
          'availability': '24/7 Emergency Support',
        },
        {
          'id': '3',
          'name': 'FarmWise AI Support',
          'type': 'email',
          'value': 'support@farmwiseai.com',
          'description': 'Technical support and app assistance',
          'region': 'National',
          'availability': '24/7',
        },
        {
          'id': '4',
          'name': 'Local Agriculture Bureau',
          'type': 'phone',
          'value': '+251933456789',
          'description': 'Local government agricultural services',
          'region': 'Amhara',
          'availability': 'Mon-Sat, 9:00 AM - 6:00 PM',
        },
        {
          'id': '5',
          'name': 'Emergency Plant Clinic',
          'type': 'phone',
          'value': '+251944567890',
          'description': 'Urgent plant disease consultation',
          'region': 'Tigray',
          'availability': '24/7',
        },
      ];

      // Filter contacts based on disease and crop relevance
      return contacts.where((contact) {
        final desc = contact['description'].toLowerCase();
        return desc.contains(diseaseLabel.toLowerCase()) ||
            desc.contains(cropName.toLowerCase()) ||
            contact['name'].toLowerCase().contains('support');
      }).toList();
    } catch (e) {
      return _getFallbackContacts();
    }
  }

  static List<Map<String, dynamic>> _getFallbackContacts() {
    return [
      {
        'id': 'fallback1',
        'name': 'Agricultural Help Line',
        'type': 'phone',
        'value': '+251911000000',
        'description': 'General agricultural support and guidance',
        'region': 'National',
        'availability': '24/7',
      },
      {
        'id': 'fallback2',
        'name': 'FarmWise AI Team',
        'type': 'email',
        'value': 'help@farmwiseai.com',
        'description': 'Get help with the app and crop issues',
        'region': 'National',
        'availability': '24/7',
      },
    ];
  }
}
