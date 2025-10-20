import 'package:flutter/material.dart';

class HelpInfoSheet extends StatefulWidget {
  const HelpInfoSheet({super.key});

  @override
  State<HelpInfoSheet> createState() => _HelpInfoSheetState();
}

class _HelpInfoSheetState extends State<HelpInfoSheet> {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: "How accurate is the disease detection?",
      answer:
          "FarmWise AI uses advanced machine learning models trained on thousands of plant disease images. The accuracy typically ranges from 85-95% depending on image quality, lighting conditions, and the specific crop. For best results, ensure clear, well-lit photos of affected plant parts.",
      icon: Icons.auto_awesome_rounded,
    ),
    FAQItem(
      question: "How do I take the best photo for detection?",
      answer:
          "For optimal results: 1) Take photos in good natural light, 2) Focus on the affected leaves/fruits/stems, 3) Capture from multiple angles if possible, 4) Ensure the plant part fills most of the frame, 5) Avoid shadows and blurry images. Clear photos significantly improve detection accuracy.",
      icon: Icons.photo_camera_rounded,
    ),
    FAQItem(
      question: "Which crops and diseases are supported?",
      answer:
          "FarmWise AI currently supports major crops including tomatoes, potatoes, corn, wheat, rice, and various fruits. We continuously add new crops and diseases. Check the app's crop selection screen for the complete updated list of supported plants.",
      icon: Icons.eco_rounded,
    ),
    FAQItem(
      question: "Can I use the app offline?",
      answer:
          "Basic disease detection works offline once you've downloaded the required models. However, AI expert advice, video resources, and article recommendations require an internet connection. Saved scans and results remain accessible offline.",
      icon: Icons.wifi_off_rounded,
    ),
    FAQItem(
      question: "How do I save my scan results?",
      answer:
          "After each scan, tap the 'Save Result' button to store the detection in your history. You can access all saved scans from the main menu under 'Saved Results'. This helps you track disease progression and treatment effectiveness over time.",
      icon: Icons.save_alt_rounded,
    ),
    FAQItem(
      question: "Are the treatment recommendations safe to use?",
      answer:
          "All recommendations are based on agricultural best practices and approved treatments. However, always follow local agricultural guidelines and consult with certified agricultural experts before applying any chemicals. Consider environmental conditions and safety precautions.",
      icon: Icons.medical_services_rounded,
    ),
    FAQItem(
      question: "How often should I scan my crops?",
      answer:
          "We recommend weekly scans during growing season for early detection. Increase frequency during high-risk periods like rainy seasons or when neighboring farms report outbreaks. Regular monitoring helps catch diseases before they spread widely.",
      icon: Icons.calendar_today_rounded,
    ),
    FAQItem(
      question: "Can I share results with agricultural experts?",
      answer:
          "Yes! Use the 'Share' feature to send detection results, images, and AI recommendations to agricultural extension officers or farming consultants. This facilitates better collaboration and expert guidance for your specific situation.",
      icon: Icons.share_rounded,
    ),
    FAQItem(
      question: "How do I update the disease database?",
      answer:
          "The app automatically updates its disease database when connected to the internet. Manual updates can be triggered in Settings > App Updates. We regularly add new diseases and improve detection models based on user feedback and agricultural research.",
      icon: Icons.update_rounded,
    ),
    FAQItem(
      question: "Is my farm data and images secure?",
      answer:
          "Yes, we take data privacy seriously. Your farm images and detection results are encrypted and stored securely. We never share your personal farm data with third parties without your explicit consent. You can delete your data anytime from the app settings.",
      icon: Icons.security_rounded,
    ),
    FAQItem(
      question: "How can I improve detection for rare diseases?",
      answer:
          "For uncommon or rare diseases, try scanning multiple affected plants from different angles. If detection confidence is low, contact our support team with clear images - this helps us improve our models for all users.",
      icon: Icons.help_rounded,
    ),
    FAQItem(
      question: "What should I do if I get conflicting results?",
      answer:
          "If you receive conflicting detection results: 1) Rescan with better lighting, 2) Take photos of multiple affected areas, 3) Check the confidence scores, 4) Consult the detailed AI advice, 5) Contact agricultural experts through the app if uncertainty persists.",
      icon: Icons.warning_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                    child: const Text("Contact Support"),
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
                    child: const Text("Close"),
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
