// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(cropName) => "Detect ${cropName} Disease";

  static String m1(cropName) => "Ask About Your ${cropName} farm...";

  static String m2(languageName) => "Language changed to ${languageName}";

  static String m3(cropName) => "${cropName} crop Selected";

  static String m4(cropName) => "Ask me anything about your ${cropName} farm.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "actionAudioFailed": MessageLookupByLibrary.simpleMessage(
      "Audio playback failed",
    ),
    "actionCamera": MessageLookupByLibrary.simpleMessage("Camera"),
    "actionClose": MessageLookupByLibrary.simpleMessage("Close"),
    "actionCopyFailed": MessageLookupByLibrary.simpleMessage(
      "Failed to copy text",
    ),
    "actionCopyText": MessageLookupByLibrary.simpleMessage("Copy text"),
    "actionGallery": MessageLookupByLibrary.simpleMessage("Gallery"),
    "actionGetStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
    "actionListenAudio": MessageLookupByLibrary.simpleMessage(
      "Listen to audio",
    ),
    "actionNoTextToSpeak": MessageLookupByLibrary.simpleMessage(
      "No text to speak",
    ),
    "actionResumeAudio": MessageLookupByLibrary.simpleMessage("Resume audio"),
    "actionSaveChat": MessageLookupByLibrary.simpleMessage("save chat result"),
    "actionSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Answer saved successfully!",
    ),
    "actionSkip": MessageLookupByLibrary.simpleMessage("Skip"),
    "actionStopAudio": MessageLookupByLibrary.simpleMessage("Stop audio"),
    "actionTextCopied": MessageLookupByLibrary.simpleMessage(
      "Text copied to clipboard!",
    ),
    "buttonDetectDisease": m0,
    "cropMango": MessageLookupByLibrary.simpleMessage("Mango"),
    "cropPotato": MessageLookupByLibrary.simpleMessage("Potato"),
    "cropTomato": MessageLookupByLibrary.simpleMessage("Tomato"),
    "drawerError": MessageLookupByLibrary.simpleMessage("Error"),
    "drawerLoading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "drawerLogoutSuccess": MessageLookupByLibrary.simpleMessage(
      "Logged out successfully",
    ),
    "drawerMenuLogout": MessageLookupByLibrary.simpleMessage("Log out"),
    "drawerMenuProfile": MessageLookupByLibrary.simpleMessage("My Profile"),
    "drawerMenuSavedChats": MessageLookupByLibrary.simpleMessage("Saved Chats"),
    "drawerMenuSavedDetections": MessageLookupByLibrary.simpleMessage(
      "Saved Detection Results",
    ),
    "drawerMenuSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "drawerUserNameDefault": MessageLookupByLibrary.simpleMessage(
      "SmartCrop User",
    ),
    "faqAccuracyAnswer": MessageLookupByLibrary.simpleMessage(
      "FarmWise AI uses advanced machine learning models trained on thousands of plant disease images. The accuracy typically ranges from 85-95% depending on image quality, lighting conditions, and the specific crop. For best results, ensure clear, well-lit photos of affected plant parts.",
    ),
    "faqAccuracyQuestion": MessageLookupByLibrary.simpleMessage(
      "How accurate is the disease detection?",
    ),
    "faqConflictingAnswer": MessageLookupByLibrary.simpleMessage(
      "If you receive conflicting detection results: 1) Rescan with better lighting, 2) Take photos of multiple affected areas, 3) Check the confidence scores, 4) Consult the detailed AI advice, 5) Contact agricultural experts through the app if uncertainty persists.",
    ),
    "faqConflictingQuestion": MessageLookupByLibrary.simpleMessage(
      "What should I do if I get conflicting results?",
    ),
    "faqFrequencyAnswer": MessageLookupByLibrary.simpleMessage(
      "We recommend weekly scans during growing season for early detection. Increase frequency during high-risk periods like rainy seasons or when neighboring farms report outbreaks. Regular monitoring helps catch diseases before they spread widely.",
    ),
    "faqFrequencyQuestion": MessageLookupByLibrary.simpleMessage(
      "How often should I scan my crops?",
    ),
    "faqOfflineAnswer": MessageLookupByLibrary.simpleMessage(
      "Basic disease detection works offline once you\'ve downloaded the required models. However, AI expert advice, video resources, and article recommendations require an internet connection. Saved scans and results remain accessible offline.",
    ),
    "faqOfflineQuestion": MessageLookupByLibrary.simpleMessage(
      "Can I use the app offline?",
    ),
    "faqPhotoTipsAnswer": MessageLookupByLibrary.simpleMessage(
      "For optimal results: 1) Take photos in good natural light, 2) Focus on the affected leaves/fruits/stems, 3) Capture from multiple angles if possible, 4) Ensure the plant part fills most of the frame, 5) Avoid shadows and blurry images. Clear photos significantly improve detection accuracy.",
    ),
    "faqPhotoTipsQuestion": MessageLookupByLibrary.simpleMessage(
      "How do I take the best photo for detection?",
    ),
    "faqPrivacyAnswer": MessageLookupByLibrary.simpleMessage(
      "Yes, we take data privacy seriously. Your farm images and detection results are encrypted and stored securely. We never share your personal farm data with third parties without your explicit consent. You can delete your data anytime from the app settings.",
    ),
    "faqPrivacyQuestion": MessageLookupByLibrary.simpleMessage(
      "Is my farm data and images secure?",
    ),
    "faqRareDiseaseAnswer": MessageLookupByLibrary.simpleMessage(
      "For uncommon or rare diseases, try scanning multiple affected plants from different angles. If detection confidence is low, contact our support team with clear images - this helps us improve our models for all users.",
    ),
    "faqRareDiseaseQuestion": MessageLookupByLibrary.simpleMessage(
      "How can I improve detection for rare diseases?",
    ),
    "faqSafetyAnswer": MessageLookupByLibrary.simpleMessage(
      "All recommendations are based on agricultural best practices and approved treatments. However, always follow local agricultural guidelines and consult with certified agricultural experts before applying any chemicals. Consider environmental conditions and safety precautions.",
    ),
    "faqSafetyQuestion": MessageLookupByLibrary.simpleMessage(
      "Are the treatment recommendations safe to use?",
    ),
    "faqSaveResultsAnswer": MessageLookupByLibrary.simpleMessage(
      "After each scan, tap the \'Save Result\' button to store the detection in your history. You can access all saved scans from the main menu under \'Saved Results\'. This helps you track disease progression and treatment effectiveness over time.",
    ),
    "faqSaveResultsQuestion": MessageLookupByLibrary.simpleMessage(
      "How do I save my scan results?",
    ),
    "faqShareAnswer": MessageLookupByLibrary.simpleMessage(
      "Yes! Use the \'Share\' feature to send detection results, images, and AI recommendations to agricultural extension officers or farming consultants. This facilitates better collaboration and expert guidance for your specific situation.",
    ),
    "faqShareQuestion": MessageLookupByLibrary.simpleMessage(
      "Can I share results with agricultural experts?",
    ),
    "faqSupportedCropsAnswer": MessageLookupByLibrary.simpleMessage(
      "FarmWise AI currently supports major crops including tomatoes, potatoes, corn, wheat, rice, and various fruits. We continuously add new crops and diseases. Check the app\'s crop selection screen for the complete updated list of supported plants.",
    ),
    "faqSupportedCropsQuestion": MessageLookupByLibrary.simpleMessage(
      "Which crops and diseases are supported?",
    ),
    "faqUpdateAnswer": MessageLookupByLibrary.simpleMessage(
      "The app automatically updates its disease database when connected to the internet. Manual updates can be triggered in Settings > App Updates. We regularly add new diseases and improve detection models based on user feedback and agricultural research.",
    ),
    "faqUpdateQuestion": MessageLookupByLibrary.simpleMessage(
      "How do I update the disease database?",
    ),
    "inputFieldHint": m1,
    "introPage1Ai": MessageLookupByLibrary.simpleMessage(" AI"),
    "introPage1Crop": MessageLookupByLibrary.simpleMessage("Crop"),
    "introPage1Description": MessageLookupByLibrary.simpleMessage(
      "Smart crop care at your fingertips - diagnose, learn, and grow better crops with AI-powered insights.",
    ),
    "introPage1Feature1": MessageLookupByLibrary.simpleMessage(
      "Instant Disease Detection",
    ),
    "introPage1Feature2": MessageLookupByLibrary.simpleMessage(
      "AI Expert Advice",
    ),
    "introPage1Feature3": MessageLookupByLibrary.simpleMessage(
      "Growth Assistant",
    ),
    "introPage1Smart": MessageLookupByLibrary.simpleMessage("Smart"),
    "introPage1Welcome": MessageLookupByLibrary.simpleMessage("Welcome to\n"),
    "introPage2Feature1Desc": MessageLookupByLibrary.simpleMessage(
      "Identify plant diseases instantly using AI technology",
    ),
    "introPage2Feature1Title": MessageLookupByLibrary.simpleMessage(
      "Disease Detection",
    ),
    "introPage2Feature2Desc": MessageLookupByLibrary.simpleMessage(
      "Get personalized recommendations for your crops",
    ),
    "introPage2Feature2Title": MessageLookupByLibrary.simpleMessage(
      "Expert Advice",
    ),
    "introPage2Feature3Desc": MessageLookupByLibrary.simpleMessage(
      "Access videos and guides for better farming",
    ),
    "introPage2Feature3Title": MessageLookupByLibrary.simpleMessage(
      "Learning Resources",
    ),
    "introPage2Subtitle": MessageLookupByLibrary.simpleMessage(
      "AI-powered tools for modern farming",
    ),
    "introPage2Title": MessageLookupByLibrary.simpleMessage(
      "What FarmWise AI\nCan Do For You",
    ),
    "languageChangedMessage": m2,
    "languageSheetFooter": MessageLookupByLibrary.simpleMessage(
      "Full language support coming in the next update",
    ),
    "languageSheetSubtitle": MessageLookupByLibrary.simpleMessage(
      "Choose your preferred language",
    ),
    "languageSheetTitle": MessageLookupByLibrary.simpleMessage(
      "Select Language",
    ),
    "mainChatCleared": MessageLookupByLibrary.simpleMessage("Chat Cleared."),
    "mainCropSelectedSnackbar": m3,
    "mainNewAssistanceTooltip": MessageLookupByLibrary.simpleMessage(
      "New Assistance",
    ),
    "mainSelectCropTitle": MessageLookupByLibrary.simpleMessage(
      "Select Crop to Assist",
    ),
    "mainTitle": MessageLookupByLibrary.simpleMessage("FarmWise AI"),
    "mainTypingStatus": MessageLookupByLibrary.simpleMessage("typing..."),
    "sectionActions": MessageLookupByLibrary.simpleMessage(
      "--- CHAT ACTIONS & TOOLTIPS ---",
    ),
    "sectionCommon": MessageLookupByLibrary.simpleMessage(
      "--- COMMON ACTIONS ---",
    ),
    "sectionCrops": MessageLookupByLibrary.simpleMessage("--- CROP NAMES ---"),
    "sectionDrawer": MessageLookupByLibrary.simpleMessage(
      "--- CUSTOM DRAWER ---",
    ),
    "sectionFaq": MessageLookupByLibrary.simpleMessage("--- FAQ CONTENT ---"),
    "sectionInput": MessageLookupByLibrary.simpleMessage("--- INPUT AREA ---"),
    "sectionIntro": MessageLookupByLibrary.simpleMessage("--- INTRO PAGES ---"),
    "sectionLanguage": MessageLookupByLibrary.simpleMessage(
      "--- LANGUAGE SHEET ---",
    ),
    "sectionMain": MessageLookupByLibrary.simpleMessage(
      "--- MAIN CHAT SCREEN ---",
    ),
    "sectionSettings": MessageLookupByLibrary.simpleMessage(
      "--- SETTINGS SCREEN ---",
    ),
    "sectionVoice": MessageLookupByLibrary.simpleMessage(
      "--- VOICE MODULE ---",
    ),
    "settingsAppDescription": MessageLookupByLibrary.simpleMessage(
      "AI-Powered Leaf Disease Diagnosis and Smart Farming Assistant",
    ),
    "settingsContactSubtitle": MessageLookupByLibrary.simpleMessage(
      "Get help from our support team",
    ),
    "settingsContactTitle": MessageLookupByLibrary.simpleMessage(
      "Contact Support",
    ),
    "settingsHelpSubtitle": MessageLookupByLibrary.simpleMessage(
      "Find answers to common questions",
    ),
    "settingsHelpTitle": MessageLookupByLibrary.simpleMessage("Help & FAQ"),
    "settingsLanguageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Select your preferred language",
    ),
    "settingsLanguageTitle": MessageLookupByLibrary.simpleMessage("Language"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("App Settings"),
    "voiceStatusListening": MessageLookupByLibrary.simpleMessage(
      "Listening...",
    ),
    "voiceStatusTapToTalk": MessageLookupByLibrary.simpleMessage("Tap To Talk"),
    "welcomeAssistantHeader": MessageLookupByLibrary.simpleMessage(
      "👩‍🌾 I\'m your Farm Assistant",
    ),
    "welcomeAssistantSubheader": m4,
  };
}
