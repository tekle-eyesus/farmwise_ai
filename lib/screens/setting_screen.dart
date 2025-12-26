import 'package:farmwise_ai/utils/snackbar_helper.dart';
import 'package:farmwise_ai/widgets/help_info_sheet.dart';
import 'package:farmwise_ai/widgets/language_selection_sheet.dart';
import 'package:farmwise_ai/widgets/settings_item_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:farmwise_ai/language_classes/language_constants.dart';

class AppSettingScreen extends StatelessWidget {
  const AppSettingScreen({super.key});

  void _showHelpInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const HelpInfoSheet(),
    );
  }

  void _showLanguageSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const LanguageSelectionSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 8, 60, 55),
                const Color.fromARGB(255, 32, 84, 35),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        title: Text(
          translation(context).settingsTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.shade100,
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  // App Logo
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.yellow,
                        width: 2,
                      ),
                    ),
                    child: Image.asset(
                      "assets/icons/farm.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Colors.deepPurple.shade600,
                        Colors.deepPurple.shade400,
                      ],
                    ).createShader(bounds),
                    child: Text(
                      "farmwise AI",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Version
                  Text(
                    "v1.0.0",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    translation(context).settingsAppDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Settings Items
            SettingsItemCard(
              icon: Icons.help_outline,
              title: translation(context).settingsHelpTitle,
              subtitle: translation(context).settingsHelpSubtitle,
              iconColor: Colors.blue,
              onTap: () => _showHelpInfo(context),
            ),
            // const SizedBox(height: 10),
            SettingsItemCard(
              icon: Icons.language,
              title: translation(context).settingsLanguageTitle,
              subtitle: translation(context).settingsLanguageSubtitle,
              iconColor: Colors.green,
              onTap: () => _showLanguageSelection(context),
            ),
            const SizedBox(height: 10),
            SettingsItemCard(
              icon: Icons.contact_support,
              title: translation(context).settingsContactTitle,
              subtitle: translation(context).settingsContactSubtitle,
              iconColor: Colors.orange,
              onTap: () async {
                // call to suport
                final String phoneNumber = '+251963815129';
                final String url = 'tel:$phoneNumber';

                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  if (context.mounted) {
                    CustomSnackBar.showWarning(
                        context, "Could not open phone dialer");
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
