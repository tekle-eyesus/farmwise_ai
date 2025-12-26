import 'package:farmwise_ai/language_classes/language_constants.dart';
import 'package:flutter/material.dart';

class HelpInfoSheet extends StatefulWidget {
  const HelpInfoSheet({super.key});

  @override
  State<HelpInfoSheet> createState() => _HelpInfoSheetState();
}

class _HelpInfoSheetState extends State<HelpInfoSheet> {
  @override
  Widget build(BuildContext context) {
    final List<FAQItem> faqItems = [
      FAQItem(
        question: translation(context).faqAccuracyQuestion,
        answer: translation(context).faqAccuracyAnswer,
        icon: Icons.auto_awesome_rounded,
      ),
      FAQItem(
        question: translation(context).faqPhotoTipsQuestion,
        answer: translation(context).faqPhotoTipsAnswer,
        icon: Icons.photo_camera_rounded,
      ),
      FAQItem(
        question: translation(context).faqSupportedCropsQuestion,
        answer: translation(context).faqSupportedCropsAnswer,
        icon: Icons.eco_rounded,
      ),
      FAQItem(
        question: translation(context).faqOfflineQuestion,
        answer: translation(context).faqOfflineAnswer,
        icon: Icons.wifi_off_rounded,
      ),
      FAQItem(
        question: translation(context).faqSaveResultsQuestion,
        answer: translation(context).faqSaveResultsAnswer,
        icon: Icons.save_alt_rounded,
      ),
      FAQItem(
        question: translation(context).faqSafetyQuestion,
        answer: translation(context).faqSafetyAnswer,
        icon: Icons.medical_services_rounded,
      ),
      FAQItem(
        question: translation(context).faqFrequencyQuestion,
        answer: translation(context).faqFrequencyAnswer,
        icon: Icons.calendar_today_rounded,
      ),
      FAQItem(
        question: translation(context).faqShareQuestion,
        answer: translation(context).faqShareAnswer,
        icon: Icons.share_rounded,
      ),
      FAQItem(
        question: translation(context).faqUpdateQuestion,
        answer: translation(context).faqUpdateAnswer,
        icon: Icons.update_rounded,
      ),
      FAQItem(
        question: translation(context).faqPrivacyQuestion,
        answer: translation(context).faqPrivacyAnswer,
        icon: Icons.security_rounded,
      ),
      FAQItem(
        question: translation(context).faqRareDiseaseQuestion,
        answer: translation(context).faqRareDiseaseAnswer,
        icon: Icons.help_rounded,
      ),
      FAQItem(
        question: translation(context).faqConflictingQuestion,
        answer: translation(context).faqConflictingAnswer,
        icon: Icons.warning_rounded,
      ),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.help_outline_rounded,
                  color: Colors.green.shade700,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  "Help & FAQ",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.green.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Find answers to commonly asked questions about our app",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: faqItems.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return ModernFAQItem(faqItem: faqItems[index]);
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Add contact support action
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green.shade800,
                      side: BorderSide(color: Colors.green.shade800),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(translation(context).settingsContactTitle),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade800,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(translation(context).actionClose),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;
  final IconData icon;

  FAQItem({
    required this.question,
    required this.answer,
    required this.icon,
  });
}

class ModernFAQItem extends StatefulWidget {
  final FAQItem faqItem;

  const ModernFAQItem({super.key, required this.faqItem});

  @override
  State<ModernFAQItem> createState() => _ModernFAQItemState();
}

class _ModernFAQItemState extends State<ModernFAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isExpanded ? Colors.greenAccent.shade100 : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: _isExpanded
            ? [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.faqItem.icon,
                        size: 18,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.faqItem.question,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.deepPurple.shade700,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                if (_isExpanded) ...[
                  const SizedBox(height: 16),
                  Divider(
                    color: Colors.grey.shade200,
                    height: 1,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.faqItem.answer,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
