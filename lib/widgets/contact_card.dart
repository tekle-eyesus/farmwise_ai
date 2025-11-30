import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String type;
  final String value;
  final String description;
  final String region;
  final String availability;
  final List<Map<String, dynamic>> detectionResult;

  const ContactCard({
    super.key,
    required this.name,
    required this.type,
    required this.value,
    required this.description,
    required this.region,
    required this.availability,
    required this.detectionResult,
  });

  String formatDetectionReport(List<dynamic> detectionResult) {
    final buffer = StringBuffer();
    buffer.writeln("Crop Disease Detection Report\n");

    for (int i = 0; i < detectionResult.length; i++) {
      final item = detectionResult[i];
      final label = item['label'];
      final confidence = (item['confidence'] as double);

      buffer.writeln("${i + 1}. $label – ${confidence.toStringAsFixed(2)}%");
    }

    return buffer.toString();
  }

  Future<void> _launchContact(BuildContext context) async {
    try {
      final Uri url;

      if (type == 'phone') {
        url = Uri.parse('tel:$value');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          _showErrorSnackBar(context, 'Could not launch $type');
        }
      } else if (type == 'email') {
        final String subject = Uri.encodeComponent('FarmWise AI Support');

        final formattedReport = formatDetectionReport(detectionResult);
        final String body = Uri.encodeComponent(
          'Hello, I need assistance with my crop disease detection.\n\n'
          '$formattedReport',
        );

        final String uriString = 'mailto:$value?subject=$subject&body=$body';
        final Uri emailLaunchUri = Uri.parse(uriString);

        if (await canLaunchUrl(emailLaunchUri)) {
          await launchUrl(emailLaunchUri);
        } else {
          _showErrorSnackBar(context, 'Could not launch $type');
        }
      } else {
        throw Exception('Unsupported contact type');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error opening $type');
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  IconData _getContactIcon() {
    switch (type) {
      case 'phone':
        return Icons.phone_rounded;
      case 'email':
        return Icons.email_rounded;
      default:
        return Icons.contact_support_rounded;
    }
  }

  Color _getContactColor() {
    switch (type) {
      case 'phone':
        return Colors.green;
      case 'email':
        return Colors.blue;
      default:
        return Colors.purple;
    }
  }

  String _getContactActionText() {
    switch (type) {
      case 'phone':
        return 'Call Now';
      case 'email':
        return 'Send Email';
      default:
        return 'Contact';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _launchContact(context),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200.withOpacity(0.8),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contact content
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.shade100,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Header with icon and type
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _getContactColor().withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: _getContactColor().withOpacity(0.3),
                                ),
                              ),
                              child: Icon(
                                _getContactIcon(),
                                size: 20,
                                color: _getContactColor(),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          _getContactColor().withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      type.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _getContactColor(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Description
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 12),

                        // Region and Availability
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              size: 12,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                region,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 12,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                availability,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Contact Button
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _getContactColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: _getContactColor().withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _getContactIcon(),
                                size: 14,
                                color: _getContactColor(),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _getContactActionText(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getContactColor(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
