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

  static String m4(err) => "Error: ${err}";

  static String m5(percent) => "${percent} confidence";

  static String m6(count) =>
      "${Intl.plural(count, one: '1 scan', other: '${count} scans')}";

  static String m7(cropName) => "${cropName} treatment for farmers agriculture";

  static String m8(cropName) => "Ask me anything about your ${cropName} farm.";

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
    "actionRemoveChat": MessageLookupByLibrary.simpleMessage(
      "Remove from Saved",
    ),
    "actionResumeAudio": MessageLookupByLibrary.simpleMessage("Resume audio"),
    "actionSaveChat": MessageLookupByLibrary.simpleMessage("save chat result"),
    "actionSaveRemoveSuccess": MessageLookupByLibrary.simpleMessage(
      "Removed from saved chats",
    ),
    "actionSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "Chat saved successfully",
    ),
    "actionSkip": MessageLookupByLibrary.simpleMessage("Skip"),
    "actionStopAudio": MessageLookupByLibrary.simpleMessage("Stop audio"),
    "actionTextCopied": MessageLookupByLibrary.simpleMessage(
      "Text copied to clipboard!",
    ),
    "buttonDetectDisease": m0,
    "commonCrop": MessageLookupByLibrary.simpleMessage("Crop"),
    "cropMango": MessageLookupByLibrary.simpleMessage("Mango"),
    "cropPotato": MessageLookupByLibrary.simpleMessage("Potato"),
    "cropTomato": MessageLookupByLibrary.simpleMessage("Tomato"),
    "detActionRemove": MessageLookupByLibrary.simpleMessage(
      "Remove from saved",
    ),
    "detActionSave": MessageLookupByLibrary.simpleMessage("Save result"),
    "detLabelAffectedArea": MessageLookupByLibrary.simpleMessage(
      "Affected Area: ",
    ),
    "detLabelSeverity": MessageLookupByLibrary.simpleMessage("Severity: "),
    "detMsgRemoved": MessageLookupByLibrary.simpleMessage(
      "Result removed from saved scans.",
    ),
    "detMsgSaved": MessageLookupByLibrary.simpleMessage(
      "Result saved successfully!",
    ),
    "detStatusHealthy": MessageLookupByLibrary.simpleMessage("Healthy"),
    "detStatusUnknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "detTitle": MessageLookupByLibrary.simpleMessage("Analysis Result"),
    "detailsActionCopy": MessageLookupByLibrary.simpleMessage("Copy Analysis"),
    "detailsAnalysisLabel": MessageLookupByLibrary.simpleMessage("AI Analysis"),
    "detailsCopySuccess": MessageLookupByLibrary.simpleMessage(
      "Analysis copied!",
    ),
    "detailsImagePreview": MessageLookupByLibrary.simpleMessage(
      "Image Preview",
    ),
    "detailsQuestionLabel": MessageLookupByLibrary.simpleMessage(
      "YOUR QUESTION",
    ),
    "detailsTitle": MessageLookupByLibrary.simpleMessage("Insight Details"),
    "detailsZoom": MessageLookupByLibrary.simpleMessage("Zoom"),
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
    "editProfileActionSave": MessageLookupByLibrary.simpleMessage(
      "Save Changes",
    ),
    "editProfileCamera": MessageLookupByLibrary.simpleMessage("Camera"),
    "editProfileFailure": MessageLookupByLibrary.simpleMessage(
      "Failed to update profile",
    ),
    "editProfileFirstName": MessageLookupByLibrary.simpleMessage("First Name"),
    "editProfileLastName": MessageLookupByLibrary.simpleMessage("Last Name"),
    "editProfilePhone": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "editProfilePhotoLibrary": MessageLookupByLibrary.simpleMessage(
      "Photo Library",
    ),
    "editProfileSaving": MessageLookupByLibrary.simpleMessage("Saving..."),
    "editProfileSuccess": MessageLookupByLibrary.simpleMessage(
      "Profile updated successfully",
    ),
    "editProfileTitle": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "errorInvalidImageBody": MessageLookupByLibrary.simpleMessage(
      "We could not identify a supported crop in this image.\n\nPlease upload a clear photo of:\n• Wheat, Potato, Pepper\n• Orange, Maize, or Apple",
    ),
    "errorInvalidImageTitle": MessageLookupByLibrary.simpleMessage(
      "Invalid Image",
    ),
    "faqAccuracyAnswer": MessageLookupByLibrary.simpleMessage(
      "SmartCrop AI uses advanced machine learning models trained on thousands of plant disease images. The accuracy typically ranges from 85-95% depending on image quality, lighting conditions, and the specific crop. For best results, ensure clear, well-lit photos of affected plant parts.",
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
      "SmartCrop AI currently supports major crops including tomatoes, potatoes, corn, wheat, rice, and various fruits. We continuously add new crops and diseases. Check the app\'s crop selection screen for the complete updated list of supported plants.",
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
    "forgotPasswordActionSend": MessageLookupByLibrary.simpleMessage(
      "Send Reset Link",
    ),
    "forgotPasswordEmailEmpty": MessageLookupByLibrary.simpleMessage(
      "Please enter your email",
    ),
    "forgotPasswordEmailInvalid": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid email",
    ),
    "forgotPasswordEmailLabel": MessageLookupByLibrary.simpleMessage(
      "Email Address",
    ),
    "forgotPasswordErrorGeneral": MessageLookupByLibrary.simpleMessage(
      "An error occurred",
    ),
    "forgotPasswordErrorInvalidFormat": MessageLookupByLibrary.simpleMessage(
      "Invalid email format.",
    ),
    "forgotPasswordErrorNoUser": MessageLookupByLibrary.simpleMessage(
      "No user found with this email.",
    ),
    "forgotPasswordErrorUnexpected": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred. Please try again.",
    ),
    "forgotPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter your email address and we will send you a link to reset your password.",
    ),
    "forgotPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Password reset link sent! Check your email.",
    ),
    "forgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset Password",
    ),
    "historyChatTitle": MessageLookupByLibrary.simpleMessage("Chat History"),
    "historyConversationLoaded": MessageLookupByLibrary.simpleMessage(
      "Conversation loaded",
    ),
    "historyDeleted": MessageLookupByLibrary.simpleMessage(
      "Conversation deleted.",
    ),
    "historyEmpty": MessageLookupByLibrary.simpleMessage("No history yet"),
    "historyTitle": MessageLookupByLibrary.simpleMessage(
      "Conversation History",
    ),
    "historyUnknownDate": MessageLookupByLibrary.simpleMessage("Unknown date"),
    "historyUntitled": MessageLookupByLibrary.simpleMessage(
      "Untitled Conversation",
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
      "What SmartCrop AI\nCan Do For You",
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
    "loginActionSignIn": MessageLookupByLibrary.simpleMessage("Sign In"),
    "loginActionSignUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "loginEmailHint": MessageLookupByLibrary.simpleMessage("Email Address"),
    "loginFirstTimePrompt": MessageLookupByLibrary.simpleMessage(
      "First Time User? ",
    ),
    "loginForgotPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot Password?",
    ),
    "loginPasswordHint": MessageLookupByLibrary.simpleMessage("Password"),
    "loginSuccess": MessageLookupByLibrary.simpleMessage("Login successful"),
    "loginTitle": MessageLookupByLibrary.simpleMessage("Login to Your Account"),
    "mainChatCleared": MessageLookupByLibrary.simpleMessage("Chat Cleared."),
    "mainChatSavedAndCleared": MessageLookupByLibrary.simpleMessage(
      "Chat saved & cleared.",
    ),
    "mainCropSelectedSnackbar": m3,
    "mainNewAssistanceTooltip": MessageLookupByLibrary.simpleMessage(
      "New Assistance",
    ),
    "mainSelectCropTitle": MessageLookupByLibrary.simpleMessage(
      "Select Crop to Assist",
    ),
    "mainStartConversationFirst": MessageLookupByLibrary.simpleMessage(
      "Start a conversation first.",
    ),
    "mainTitle": MessageLookupByLibrary.simpleMessage("SmartCrop AI"),
    "mainTypingStatus": MessageLookupByLibrary.simpleMessage("typing..."),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "profileActionEdit": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "profileEmailLabel": MessageLookupByLibrary.simpleMessage("Email Address"),
    "profileError": m4,
    "profilePhoneLabel": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "profileTitle": MessageLookupByLibrary.simpleMessage("My Profile"),
    "profileUserNotFound": MessageLookupByLibrary.simpleMessage(
      "User not found",
    ),
    "profileValueNotSet": MessageLookupByLibrary.simpleMessage("Not set"),
    "registerActionButton": MessageLookupByLibrary.simpleMessage("Register"),
    "registerActionLogin": MessageLookupByLibrary.simpleMessage("Login"),
    "registerAlreadyAccountPrompt": MessageLookupByLibrary.simpleMessage(
      "Already have an account? ",
    ),
    "registerConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "registerEmail": MessageLookupByLibrary.simpleMessage("Email"),
    "registerEmailHint": MessageLookupByLibrary.simpleMessage("Enter email"),
    "registerFirstName": MessageLookupByLibrary.simpleMessage("First Name"),
    "registerFirstNameHint": MessageLookupByLibrary.simpleMessage(
      "Enter first name",
    ),
    "registerLastName": MessageLookupByLibrary.simpleMessage("Last Name"),
    "registerLastNameHint": MessageLookupByLibrary.simpleMessage(
      "Enter last name",
    ),
    "registerPassword": MessageLookupByLibrary.simpleMessage("Password"),
    "registerPasswordMatchError": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "registerPasswordValidation": MessageLookupByLibrary.simpleMessage(
      "Password must be 6+ chars",
    ),
    "registerPhone": MessageLookupByLibrary.simpleMessage("Phone Number"),
    "registerPhoneHint": MessageLookupByLibrary.simpleMessage("Enter phone"),
    "registerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Create your new account",
    ),
    "registerSuccess": MessageLookupByLibrary.simpleMessage(
      "Registration successful",
    ),
    "registerTermsError": MessageLookupByLibrary.simpleMessage(
      "Please accept terms and conditions",
    ),
    "registerTermsLabel": MessageLookupByLibrary.simpleMessage(
      "I accept Terms and Conditions",
    ),
    "registerTitle": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "savedActionView": MessageLookupByLibrary.simpleMessage("View Analysis"),
    "savedDeleteSuccess": MessageLookupByLibrary.simpleMessage(
      "Deleted successfully",
    ),
    "savedDialogDeleteBody": MessageLookupByLibrary.simpleMessage(
      "This action cannot be undone. Are you sure?",
    ),
    "savedDialogDeleteTitle": MessageLookupByLibrary.simpleMessage(
      "Delete Insight?",
    ),
    "savedEmptyState": MessageLookupByLibrary.simpleMessage(
      "No Saved Insights Yet",
    ),
    "savedEmptySubtitle": MessageLookupByLibrary.simpleMessage(
      "Save important advice to access it offline later.",
    ),
    "savedTitle": MessageLookupByLibrary.simpleMessage("Saved Insights"),
    "scansActionStartNew": MessageLookupByLibrary.simpleMessage(
      "Start New Scan",
    ),
    "scansConfidenceLabel": m5,
    "scansCount": m6,
    "scansDeleteDialogBody": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this scan result?",
    ),
    "scansDeleteDialogTitle": MessageLookupByLibrary.simpleMessage(
      "Delete Scan",
    ),
    "scansDeleteTooltip": MessageLookupByLibrary.simpleMessage("Delete scan"),
    "scansDeletedSnackbar": MessageLookupByLibrary.simpleMessage(
      "Scan deleted",
    ),
    "scansEmptyState": MessageLookupByLibrary.simpleMessage("No Saved Scans"),
    "scansEmptySubtitle": MessageLookupByLibrary.simpleMessage(
      "Your plant disease detection scans will appear here for future reference.",
    ),
    "scansTitle": MessageLookupByLibrary.simpleMessage("Saved Scans"),
    "scansTotalCount": MessageLookupByLibrary.simpleMessage("Total Scans"),
    "scansUnknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "sectionActions": MessageLookupByLibrary.simpleMessage(
      "--- CHAT ACTIONS & TOOLTIPS ---",
    ),
    "sectionCommon": MessageLookupByLibrary.simpleMessage(
      "--- COMMON ACTIONS ---",
    ),
    "sectionCrops": MessageLookupByLibrary.simpleMessage("--- CROP NAMES ---"),
    "sectionDetails": MessageLookupByLibrary.simpleMessage(
      "--- INSIGHT DETAILS SCREEN ---",
    ),
    "sectionDetection": MessageLookupByLibrary.simpleMessage(
      "--- DETECTION RESULT SCREEN ---",
    ),
    "sectionDrawer": MessageLookupByLibrary.simpleMessage(
      "--- CUSTOM DRAWER ---",
    ),
    "sectionEditProfile": MessageLookupByLibrary.simpleMessage(
      "--- EDIT PROFILE SCREEN ---",
    ),
    "sectionErrors": MessageLookupByLibrary.simpleMessage(
      "--- ERROR DIALOGS ---",
    ),
    "sectionFaq": MessageLookupByLibrary.simpleMessage("--- FAQ CONTENT ---"),
    "sectionForgotPassword": MessageLookupByLibrary.simpleMessage(
      "--- FORGOT PASSWORD ---",
    ),
    "sectionHistory": MessageLookupByLibrary.simpleMessage(
      "--- CONVERSATION HISTORY ---",
    ),
    "sectionInput": MessageLookupByLibrary.simpleMessage("--- INPUT AREA ---"),
    "sectionIntro": MessageLookupByLibrary.simpleMessage("--- INTRO PAGES ---"),
    "sectionLanguage": MessageLookupByLibrary.simpleMessage(
      "--- LANGUAGE SHEET ---",
    ),
    "sectionLogin": MessageLookupByLibrary.simpleMessage(
      "--- LOGIN SCREEN ---",
    ),
    "sectionMain": MessageLookupByLibrary.simpleMessage(
      "--- MAIN CHAT SCREEN ---",
    ),
    "sectionProfile": MessageLookupByLibrary.simpleMessage(
      "--- PROFILE SCREEN ---",
    ),
    "sectionRegister": MessageLookupByLibrary.simpleMessage(
      "--- REGISTER SCREEN ---",
    ),
    "sectionSaved": MessageLookupByLibrary.simpleMessage(
      "--- SAVED INSIGHTS SCREEN ---",
    ),
    "sectionSavedScans": MessageLookupByLibrary.simpleMessage(
      "------------------ SAVED SCANS SCREEN --------------------",
    ),
    "sectionSettings": MessageLookupByLibrary.simpleMessage(
      "--- SETTINGS SCREEN ---",
    ),
    "sectionVideos": MessageLookupByLibrary.simpleMessage(
      "--- VIDEO RESOURCES ---",
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
    "videoActionTryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
    "videoEmptyState": MessageLookupByLibrary.simpleMessage("No videos found"),
    "videoEmptySubtitle": MessageLookupByLibrary.simpleMessage(
      "Try searching with different keywords",
    ),
    "videoErrorLoad": MessageLookupByLibrary.simpleMessage(
      "Failed to load videos",
    ),
    "videoLoading": MessageLookupByLibrary.simpleMessage(
      "Loading helpful videos...",
    ),
    "videoRefreshTooltip": MessageLookupByLibrary.simpleMessage(
      "Refresh videos",
    ),
    "videoSearchQuery": m7,
    "videoSwipeHint": MessageLookupByLibrary.simpleMessage(
      "Swipe for more videos →",
    ),
    "videoTitle": MessageLookupByLibrary.simpleMessage("Video Resources"),
    "voiceStatusListening": MessageLookupByLibrary.simpleMessage(
      "Listening...",
    ),
    "voiceStatusTapToTalk": MessageLookupByLibrary.simpleMessage("Tap To Talk"),
    "welcomeAssistantHeader": MessageLookupByLibrary.simpleMessage(
      "👩‍🌾 I\'m your Farm Assistant",
    ),
    "welcomeAssistantSubheader": m8,
    "yes": MessageLookupByLibrary.simpleMessage("Yes"),
  };
}
