// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `--- COMMON ACTIONS ---`
  String get sectionCommon {
    return Intl.message(
      '--- COMMON ACTIONS ---',
      name: 'sectionCommon',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get actionClose {
    return Intl.message('Close', name: 'actionClose', desc: '', args: []);
  }

  /// `--- SETTINGS SCREEN ---`
  String get sectionSettings {
    return Intl.message(
      '--- SETTINGS SCREEN ---',
      name: 'sectionSettings',
      desc: '',
      args: [],
    );
  }

  /// `App Settings`
  String get settingsTitle {
    return Intl.message(
      'App Settings',
      name: 'settingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `AI-Powered Leaf Disease Diagnosis and Smart Farming Assistant`
  String get settingsAppDescription {
    return Intl.message(
      'AI-Powered Leaf Disease Diagnosis and Smart Farming Assistant',
      name: 'settingsAppDescription',
      desc: '',
      args: [],
    );
  }

  /// `Help & FAQ`
  String get settingsHelpTitle {
    return Intl.message(
      'Help & FAQ',
      name: 'settingsHelpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Find answers to common questions`
  String get settingsHelpSubtitle {
    return Intl.message(
      'Find answers to common questions',
      name: 'settingsHelpSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsLanguageTitle {
    return Intl.message(
      'Language',
      name: 'settingsLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select your preferred language`
  String get settingsLanguageSubtitle {
    return Intl.message(
      'Select your preferred language',
      name: 'settingsLanguageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Contact Support`
  String get settingsContactTitle {
    return Intl.message(
      'Contact Support',
      name: 'settingsContactTitle',
      desc: '',
      args: [],
    );
  }

  /// `Get help from our support team`
  String get settingsContactSubtitle {
    return Intl.message(
      'Get help from our support team',
      name: 'settingsContactSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `--- LANGUAGE SHEET ---`
  String get sectionLanguage {
    return Intl.message(
      '--- LANGUAGE SHEET ---',
      name: 'sectionLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get languageSheetTitle {
    return Intl.message(
      'Select Language',
      name: 'languageSheetTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose your preferred language`
  String get languageSheetSubtitle {
    return Intl.message(
      'Choose your preferred language',
      name: 'languageSheetSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Full language support coming in the next update`
  String get languageSheetFooter {
    return Intl.message(
      'Full language support coming in the next update',
      name: 'languageSheetFooter',
      desc: '',
      args: [],
    );
  }

  /// `Language changed to {languageName}`
  String languageChangedMessage(String languageName) {
    return Intl.message(
      'Language changed to $languageName',
      name: 'languageChangedMessage',
      desc: '',
      args: [languageName],
    );
  }

  /// `--- FAQ CONTENT ---`
  String get sectionFaq {
    return Intl.message(
      '--- FAQ CONTENT ---',
      name: 'sectionFaq',
      desc: '',
      args: [],
    );
  }

  /// `How accurate is the disease detection?`
  String get faqAccuracyQuestion {
    return Intl.message(
      'How accurate is the disease detection?',
      name: 'faqAccuracyQuestion',
      desc: '',
      args: [],
    );
  }

  /// `FarmWise AI uses advanced machine learning models trained on thousands of plant disease images. The accuracy typically ranges from 85-95% depending on image quality, lighting conditions, and the specific crop. For best results, ensure clear, well-lit photos of affected plant parts.`
  String get faqAccuracyAnswer {
    return Intl.message(
      'FarmWise AI uses advanced machine learning models trained on thousands of plant disease images. The accuracy typically ranges from 85-95% depending on image quality, lighting conditions, and the specific crop. For best results, ensure clear, well-lit photos of affected plant parts.',
      name: 'faqAccuracyAnswer',
      desc: '',
      args: [],
    );
  }

  /// `How do I take the best photo for detection?`
  String get faqPhotoTipsQuestion {
    return Intl.message(
      'How do I take the best photo for detection?',
      name: 'faqPhotoTipsQuestion',
      desc: '',
      args: [],
    );
  }

  /// `For optimal results: 1) Take photos in good natural light, 2) Focus on the affected leaves/fruits/stems, 3) Capture from multiple angles if possible, 4) Ensure the plant part fills most of the frame, 5) Avoid shadows and blurry images. Clear photos significantly improve detection accuracy.`
  String get faqPhotoTipsAnswer {
    return Intl.message(
      'For optimal results: 1) Take photos in good natural light, 2) Focus on the affected leaves/fruits/stems, 3) Capture from multiple angles if possible, 4) Ensure the plant part fills most of the frame, 5) Avoid shadows and blurry images. Clear photos significantly improve detection accuracy.',
      name: 'faqPhotoTipsAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Which crops and diseases are supported?`
  String get faqSupportedCropsQuestion {
    return Intl.message(
      'Which crops and diseases are supported?',
      name: 'faqSupportedCropsQuestion',
      desc: '',
      args: [],
    );
  }

  /// `FarmWise AI currently supports major crops including tomatoes, potatoes, corn, wheat, rice, and various fruits. We continuously add new crops and diseases. Check the app's crop selection screen for the complete updated list of supported plants.`
  String get faqSupportedCropsAnswer {
    return Intl.message(
      'FarmWise AI currently supports major crops including tomatoes, potatoes, corn, wheat, rice, and various fruits. We continuously add new crops and diseases. Check the app\'s crop selection screen for the complete updated list of supported plants.',
      name: 'faqSupportedCropsAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Can I use the app offline?`
  String get faqOfflineQuestion {
    return Intl.message(
      'Can I use the app offline?',
      name: 'faqOfflineQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Basic disease detection works offline once you've downloaded the required models. However, AI expert advice, video resources, and article recommendations require an internet connection. Saved scans and results remain accessible offline.`
  String get faqOfflineAnswer {
    return Intl.message(
      'Basic disease detection works offline once you\'ve downloaded the required models. However, AI expert advice, video resources, and article recommendations require an internet connection. Saved scans and results remain accessible offline.',
      name: 'faqOfflineAnswer',
      desc: '',
      args: [],
    );
  }

  /// `How do I save my scan results?`
  String get faqSaveResultsQuestion {
    return Intl.message(
      'How do I save my scan results?',
      name: 'faqSaveResultsQuestion',
      desc: '',
      args: [],
    );
  }

  /// `After each scan, tap the 'Save Result' button to store the detection in your history. You can access all saved scans from the main menu under 'Saved Results'. This helps you track disease progression and treatment effectiveness over time.`
  String get faqSaveResultsAnswer {
    return Intl.message(
      'After each scan, tap the \'Save Result\' button to store the detection in your history. You can access all saved scans from the main menu under \'Saved Results\'. This helps you track disease progression and treatment effectiveness over time.',
      name: 'faqSaveResultsAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Are the treatment recommendations safe to use?`
  String get faqSafetyQuestion {
    return Intl.message(
      'Are the treatment recommendations safe to use?',
      name: 'faqSafetyQuestion',
      desc: '',
      args: [],
    );
  }

  /// `All recommendations are based on agricultural best practices and approved treatments. However, always follow local agricultural guidelines and consult with certified agricultural experts before applying any chemicals. Consider environmental conditions and safety precautions.`
  String get faqSafetyAnswer {
    return Intl.message(
      'All recommendations are based on agricultural best practices and approved treatments. However, always follow local agricultural guidelines and consult with certified agricultural experts before applying any chemicals. Consider environmental conditions and safety precautions.',
      name: 'faqSafetyAnswer',
      desc: '',
      args: [],
    );
  }

  /// `How often should I scan my crops?`
  String get faqFrequencyQuestion {
    return Intl.message(
      'How often should I scan my crops?',
      name: 'faqFrequencyQuestion',
      desc: '',
      args: [],
    );
  }

  /// `We recommend weekly scans during growing season for early detection. Increase frequency during high-risk periods like rainy seasons or when neighboring farms report outbreaks. Regular monitoring helps catch diseases before they spread widely.`
  String get faqFrequencyAnswer {
    return Intl.message(
      'We recommend weekly scans during growing season for early detection. Increase frequency during high-risk periods like rainy seasons or when neighboring farms report outbreaks. Regular monitoring helps catch diseases before they spread widely.',
      name: 'faqFrequencyAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Can I share results with agricultural experts?`
  String get faqShareQuestion {
    return Intl.message(
      'Can I share results with agricultural experts?',
      name: 'faqShareQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Yes! Use the 'Share' feature to send detection results, images, and AI recommendations to agricultural extension officers or farming consultants. This facilitates better collaboration and expert guidance for your specific situation.`
  String get faqShareAnswer {
    return Intl.message(
      'Yes! Use the \'Share\' feature to send detection results, images, and AI recommendations to agricultural extension officers or farming consultants. This facilitates better collaboration and expert guidance for your specific situation.',
      name: 'faqShareAnswer',
      desc: '',
      args: [],
    );
  }

  /// `How do I update the disease database?`
  String get faqUpdateQuestion {
    return Intl.message(
      'How do I update the disease database?',
      name: 'faqUpdateQuestion',
      desc: '',
      args: [],
    );
  }

  /// `The app automatically updates its disease database when connected to the internet. Manual updates can be triggered in Settings > App Updates. We regularly add new diseases and improve detection models based on user feedback and agricultural research.`
  String get faqUpdateAnswer {
    return Intl.message(
      'The app automatically updates its disease database when connected to the internet. Manual updates can be triggered in Settings > App Updates. We regularly add new diseases and improve detection models based on user feedback and agricultural research.',
      name: 'faqUpdateAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Is my farm data and images secure?`
  String get faqPrivacyQuestion {
    return Intl.message(
      'Is my farm data and images secure?',
      name: 'faqPrivacyQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Yes, we take data privacy seriously. Your farm images and detection results are encrypted and stored securely. We never share your personal farm data with third parties without your explicit consent. You can delete your data anytime from the app settings.`
  String get faqPrivacyAnswer {
    return Intl.message(
      'Yes, we take data privacy seriously. Your farm images and detection results are encrypted and stored securely. We never share your personal farm data with third parties without your explicit consent. You can delete your data anytime from the app settings.',
      name: 'faqPrivacyAnswer',
      desc: '',
      args: [],
    );
  }

  /// `How can I improve detection for rare diseases?`
  String get faqRareDiseaseQuestion {
    return Intl.message(
      'How can I improve detection for rare diseases?',
      name: 'faqRareDiseaseQuestion',
      desc: '',
      args: [],
    );
  }

  /// `For uncommon or rare diseases, try scanning multiple affected plants from different angles. If detection confidence is low, contact our support team with clear images - this helps us improve our models for all users.`
  String get faqRareDiseaseAnswer {
    return Intl.message(
      'For uncommon or rare diseases, try scanning multiple affected plants from different angles. If detection confidence is low, contact our support team with clear images - this helps us improve our models for all users.',
      name: 'faqRareDiseaseAnswer',
      desc: '',
      args: [],
    );
  }

  /// `What should I do if I get conflicting results?`
  String get faqConflictingQuestion {
    return Intl.message(
      'What should I do if I get conflicting results?',
      name: 'faqConflictingQuestion',
      desc: '',
      args: [],
    );
  }

  /// `If you receive conflicting detection results: 1) Rescan with better lighting, 2) Take photos of multiple affected areas, 3) Check the confidence scores, 4) Consult the detailed AI advice, 5) Contact agricultural experts through the app if uncertainty persists.`
  String get faqConflictingAnswer {
    return Intl.message(
      'If you receive conflicting detection results: 1) Rescan with better lighting, 2) Take photos of multiple affected areas, 3) Check the confidence scores, 4) Consult the detailed AI advice, 5) Contact agricultural experts through the app if uncertainty persists.',
      name: 'faqConflictingAnswer',
      desc: '',
      args: [],
    );
  }

  /// `--- CUSTOM DRAWER ---`
  String get sectionDrawer {
    return Intl.message(
      '--- CUSTOM DRAWER ---',
      name: 'sectionDrawer',
      desc: '',
      args: [],
    );
  }

  /// `SmartCrop User`
  String get drawerUserNameDefault {
    return Intl.message(
      'SmartCrop User',
      name: 'drawerUserNameDefault',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get drawerLoading {
    return Intl.message(
      'Loading...',
      name: 'drawerLoading',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get drawerError {
    return Intl.message('Error', name: 'drawerError', desc: '', args: []);
  }

  /// `Saved Chats`
  String get drawerMenuSavedChats {
    return Intl.message(
      'Saved Chats',
      name: 'drawerMenuSavedChats',
      desc: '',
      args: [],
    );
  }

  /// `Saved Detection Results`
  String get drawerMenuSavedDetections {
    return Intl.message(
      'Saved Detection Results',
      name: 'drawerMenuSavedDetections',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get drawerMenuSettings {
    return Intl.message(
      'Settings',
      name: 'drawerMenuSettings',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get drawerMenuProfile {
    return Intl.message(
      'My Profile',
      name: 'drawerMenuProfile',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get drawerMenuLogout {
    return Intl.message(
      'Log out',
      name: 'drawerMenuLogout',
      desc: '',
      args: [],
    );
  }

  /// `Logged out successfully`
  String get drawerLogoutSuccess {
    return Intl.message(
      'Logged out successfully',
      name: 'drawerLogoutSuccess',
      desc: '',
      args: [],
    );
  }

  /// `--- MAIN CHAT SCREEN ---`
  String get sectionMain {
    return Intl.message(
      '--- MAIN CHAT SCREEN ---',
      name: 'sectionMain',
      desc: '',
      args: [],
    );
  }

  /// `FarmWise AI`
  String get mainTitle {
    return Intl.message('FarmWise AI', name: 'mainTitle', desc: '', args: []);
  }

  /// `typing...`
  String get mainTypingStatus {
    return Intl.message(
      'typing...',
      name: 'mainTypingStatus',
      desc: '',
      args: [],
    );
  }

  /// `New Assistance`
  String get mainNewAssistanceTooltip {
    return Intl.message(
      'New Assistance',
      name: 'mainNewAssistanceTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Chat Cleared.`
  String get mainChatCleared {
    return Intl.message(
      'Chat Cleared.',
      name: 'mainChatCleared',
      desc: '',
      args: [],
    );
  }

  /// `Select Crop to Assist`
  String get mainSelectCropTitle {
    return Intl.message(
      'Select Crop to Assist',
      name: 'mainSelectCropTitle',
      desc: '',
      args: [],
    );
  }

  /// `{cropName} crop Selected`
  String mainCropSelectedSnackbar(String cropName) {
    return Intl.message(
      '$cropName crop Selected',
      name: 'mainCropSelectedSnackbar',
      desc: '',
      args: [cropName],
    );
  }

  /// `--- CROP NAMES ---`
  String get sectionCrops {
    return Intl.message(
      '--- CROP NAMES ---',
      name: 'sectionCrops',
      desc: '',
      args: [],
    );
  }

  /// `Tomato`
  String get cropTomato {
    return Intl.message('Tomato', name: 'cropTomato', desc: '', args: []);
  }

  /// `Potato`
  String get cropPotato {
    return Intl.message('Potato', name: 'cropPotato', desc: '', args: []);
  }

  /// `Mango`
  String get cropMango {
    return Intl.message('Mango', name: 'cropMango', desc: '', args: []);
  }

  /// `--- CHAT ACTIONS & TOOLTIPS ---`
  String get sectionActions {
    return Intl.message(
      '--- CHAT ACTIONS & TOOLTIPS ---',
      name: 'sectionActions',
      desc: '',
      args: [],
    );
  }

  /// `Copy text`
  String get actionCopyText {
    return Intl.message(
      'Copy text',
      name: 'actionCopyText',
      desc: '',
      args: [],
    );
  }

  /// `Text copied to clipboard!`
  String get actionTextCopied {
    return Intl.message(
      'Text copied to clipboard!',
      name: 'actionTextCopied',
      desc: '',
      args: [],
    );
  }

  /// `Failed to copy text`
  String get actionCopyFailed {
    return Intl.message(
      'Failed to copy text',
      name: 'actionCopyFailed',
      desc: '',
      args: [],
    );
  }

  /// `Stop audio`
  String get actionStopAudio {
    return Intl.message(
      'Stop audio',
      name: 'actionStopAudio',
      desc: '',
      args: [],
    );
  }

  /// `Resume audio`
  String get actionResumeAudio {
    return Intl.message(
      'Resume audio',
      name: 'actionResumeAudio',
      desc: '',
      args: [],
    );
  }

  /// `Listen to audio`
  String get actionListenAudio {
    return Intl.message(
      'Listen to audio',
      name: 'actionListenAudio',
      desc: '',
      args: [],
    );
  }

  /// `No text to speak`
  String get actionNoTextToSpeak {
    return Intl.message(
      'No text to speak',
      name: 'actionNoTextToSpeak',
      desc: '',
      args: [],
    );
  }

  /// `Audio playback failed`
  String get actionAudioFailed {
    return Intl.message(
      'Audio playback failed',
      name: 'actionAudioFailed',
      desc: '',
      args: [],
    );
  }

  /// `save chat result`
  String get actionSaveChat {
    return Intl.message(
      'save chat result',
      name: 'actionSaveChat',
      desc: '',
      args: [],
    );
  }

  /// `Answer saved successfully!`
  String get actionSaveSuccess {
    return Intl.message(
      'Answer saved successfully!',
      name: 'actionSaveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get actionCamera {
    return Intl.message('Camera', name: 'actionCamera', desc: '', args: []);
  }

  /// `Gallery`
  String get actionGallery {
    return Intl.message('Gallery', name: 'actionGallery', desc: '', args: []);
  }

  /// `--- INPUT AREA ---`
  String get sectionInput {
    return Intl.message(
      '--- INPUT AREA ---',
      name: 'sectionInput',
      desc: '',
      args: [],
    );
  }

  /// `Ask About Your {cropName} farm...`
  String inputFieldHint(String cropName) {
    return Intl.message(
      'Ask About Your $cropName farm...',
      name: 'inputFieldHint',
      desc: '',
      args: [cropName],
    );
  }

  /// `Detect {cropName} Disease`
  String buttonDetectDisease(String cropName) {
    return Intl.message(
      'Detect $cropName Disease',
      name: 'buttonDetectDisease',
      desc: '',
      args: [cropName],
    );
  }

  /// `👩‍🌾 I'm your Farm Assistant`
  String get welcomeAssistantHeader {
    return Intl.message(
      '👩‍🌾 I\'m your Farm Assistant',
      name: 'welcomeAssistantHeader',
      desc: '',
      args: [],
    );
  }

  /// `Ask me anything about your {cropName} farm.`
  String welcomeAssistantSubheader(String cropName) {
    return Intl.message(
      'Ask me anything about your $cropName farm.',
      name: 'welcomeAssistantSubheader',
      desc: '',
      args: [cropName],
    );
  }

  /// `--- VOICE MODULE ---`
  String get sectionVoice {
    return Intl.message(
      '--- VOICE MODULE ---',
      name: 'sectionVoice',
      desc: '',
      args: [],
    );
  }

  /// `Listening...`
  String get voiceStatusListening {
    return Intl.message(
      'Listening...',
      name: 'voiceStatusListening',
      desc: '',
      args: [],
    );
  }

  /// `Tap To Talk`
  String get voiceStatusTapToTalk {
    return Intl.message(
      'Tap To Talk',
      name: 'voiceStatusTapToTalk',
      desc: '',
      args: [],
    );
  }

  /// `--- INTRO PAGES ---`
  String get sectionIntro {
    return Intl.message(
      '--- INTRO PAGES ---',
      name: 'sectionIntro',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to\n`
  String get introPage1Welcome {
    return Intl.message(
      'Welcome to\n',
      name: 'introPage1Welcome',
      desc: '',
      args: [],
    );
  }

  /// `Smart`
  String get introPage1Smart {
    return Intl.message('Smart', name: 'introPage1Smart', desc: '', args: []);
  }

  /// `Crop`
  String get introPage1Crop {
    return Intl.message('Crop', name: 'introPage1Crop', desc: '', args: []);
  }

  /// ` AI`
  String get introPage1Ai {
    return Intl.message(' AI', name: 'introPage1Ai', desc: '', args: []);
  }

  /// `Smart crop care at your fingertips - diagnose, learn, and grow better crops with AI-powered insights.`
  String get introPage1Description {
    return Intl.message(
      'Smart crop care at your fingertips - diagnose, learn, and grow better crops with AI-powered insights.',
      name: 'introPage1Description',
      desc: '',
      args: [],
    );
  }

  /// `Instant Disease Detection`
  String get introPage1Feature1 {
    return Intl.message(
      'Instant Disease Detection',
      name: 'introPage1Feature1',
      desc: '',
      args: [],
    );
  }

  /// `AI Expert Advice`
  String get introPage1Feature2 {
    return Intl.message(
      'AI Expert Advice',
      name: 'introPage1Feature2',
      desc: '',
      args: [],
    );
  }

  /// `Growth Assistant`
  String get introPage1Feature3 {
    return Intl.message(
      'Growth Assistant',
      name: 'introPage1Feature3',
      desc: '',
      args: [],
    );
  }

  /// `What FarmWise AI\nCan Do For You`
  String get introPage2Title {
    return Intl.message(
      'What FarmWise AI\nCan Do For You',
      name: 'introPage2Title',
      desc: '',
      args: [],
    );
  }

  /// `AI-powered tools for modern farming`
  String get introPage2Subtitle {
    return Intl.message(
      'AI-powered tools for modern farming',
      name: 'introPage2Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Disease Detection`
  String get introPage2Feature1Title {
    return Intl.message(
      'Disease Detection',
      name: 'introPage2Feature1Title',
      desc: '',
      args: [],
    );
  }

  /// `Identify plant diseases instantly using AI technology`
  String get introPage2Feature1Desc {
    return Intl.message(
      'Identify plant diseases instantly using AI technology',
      name: 'introPage2Feature1Desc',
      desc: '',
      args: [],
    );
  }

  /// `Expert Advice`
  String get introPage2Feature2Title {
    return Intl.message(
      'Expert Advice',
      name: 'introPage2Feature2Title',
      desc: '',
      args: [],
    );
  }

  /// `Get personalized recommendations for your crops`
  String get introPage2Feature2Desc {
    return Intl.message(
      'Get personalized recommendations for your crops',
      name: 'introPage2Feature2Desc',
      desc: '',
      args: [],
    );
  }

  /// `Learning Resources`
  String get introPage2Feature3Title {
    return Intl.message(
      'Learning Resources',
      name: 'introPage2Feature3Title',
      desc: '',
      args: [],
    );
  }

  /// `Access videos and guides for better farming`
  String get introPage2Feature3Desc {
    return Intl.message(
      'Access videos and guides for better farming',
      name: 'introPage2Feature3Desc',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
