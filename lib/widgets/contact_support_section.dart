import 'package:flutter/material.dart';
import '../services/contact_service.dart';
import 'contact_card.dart';

class ContactSupportSection extends StatefulWidget {
  final String diseaseLabel;
  final String cropName;
  final List<Map<String, dynamic>> detectionResult;

  const ContactSupportSection({
    super.key,
    required this.diseaseLabel,
    required this.cropName,
    required this.detectionResult,
  });

  @override
  State<ContactSupportSection> createState() => _ContactSupportSectionState();
}

class _ContactSupportSectionState extends State<ContactSupportSection> {
  List<Map<String, dynamic>> _contacts = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    try {
      final results = await ContactService.fetchContacts(
        widget.diseaseLabel,
        widget.cropName,
      );
      setState(() {
        _contacts = results;
        _isLoading = false;
        _hasError = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header with refresh button
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal.shade400,
                        Colors.teal.shade600,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Contact Support",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800,
                  ),
                ),
                const Spacer(),
                if (!_isLoading && _contacts.isNotEmpty)
                  IconButton(
                    onPressed: _loadContacts,
                    icon: Icon(
                      Icons.refresh_rounded,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                    tooltip: 'Refresh contacts',
                  ),
              ],
            ),
          ),

          // Content Area
          if (_isLoading) _buildLoadingState(),
          if (_hasError) _buildErrorState(),
          if (!_isLoading && !_hasError && _contacts.isEmpty)
            _buildEmptyState(),
          if (!_isLoading && !_hasError && _contacts.isNotEmpty)
            _buildContactList(),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal.shade400),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Loading support contacts...',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 32,
            color: Colors.teal.shade400,
          ),
          const SizedBox(height: 8),
          Text(
            'Failed to load contacts',
            style: TextStyle(
              color: Colors.teal.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _loadContacts,
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade500,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.contact_phone_rounded,
            size: 32,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 8),
          Text(
            'No contacts available',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Try refreshing or check back later',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactList() {
    return Column(
      children: [
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _contacts.length,
            itemBuilder: (context, index) {
              final contact = _contacts[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index == _contacts.length - 1 ? 0 : 16,
                ),
                child: ContactCard(
                  name: contact['name'],
                  type: contact['type'],
                  value: contact['value'],
                  description: contact['description'],
                  region: contact['region'],
                  availability: contact['availability'],
                  detectionResult: widget.detectionResult,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Swipe for more contacts →',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
