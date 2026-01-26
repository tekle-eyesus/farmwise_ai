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

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
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

  /// `SmartCrop AI uses advanced machine learning models trained on thousands of plant disease images. The accuracy typically ranges from 85-95% depending on image quality, lighting conditions, and the specific crop. For best results, ensure clear, well-lit photos of affected plant parts.`
  String get faqAccuracyAnswer {
    return Intl.message(
      'SmartCrop AI uses advanced machine learning models trained on thousands of plant disease images. The accuracy typically ranges from 85-95% depending on image quality, lighting conditions, and the specific crop. For best results, ensure clear, well-lit photos of affected plant parts.',
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

  /// `SmartCrop AI currently supports major crops including tomatoes, potatoes, corn, wheat, rice, and various fruits. We continuously add new crops and diseases. Check the app's crop selection screen for the complete updated list of supported plants.`
  String get faqSupportedCropsAnswer {
    return Intl.message(
      'SmartCrop AI currently supports major crops including tomatoes, potatoes, corn, wheat, rice, and various fruits. We continuously add new crops and diseases. Check the app\'s crop selection screen for the complete updated list of supported plants.',
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

  /// `SmartCrop AI`
  String get mainTitle {
    return Intl.message('SmartCrop AI', name: 'mainTitle', desc: '', args: []);
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

  /// `Remove from Saved`
  String get actionRemoveChat {
    return Intl.message(
      'Remove from Saved',
      name: 'actionRemoveChat',
      desc: '',
      args: [],
    );
  }

  /// `Chat saved successfully`
  String get actionSaveSuccess {
    return Intl.message(
      'Chat saved successfully',
      name: 'actionSaveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Removed from saved chats`
  String get actionSaveRemoveSuccess {
    return Intl.message(
      'Removed from saved chats',
      name: 'actionSaveRemoveSuccess',
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

  /// `What SmartCrop AI\nCan Do For You`
  String get introPage2Title {
    return Intl.message(
      'What SmartCrop AI\nCan Do For You',
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

  /// `Skip`
  String get actionSkip {
    return Intl.message('Skip', name: 'actionSkip', desc: '', args: []);
  }

  /// `Get Started`
  String get actionGetStarted {
    return Intl.message(
      'Get Started',
      name: 'actionGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `--- SAVED INSIGHTS SCREEN ---`
  String get sectionSaved {
    return Intl.message(
      '--- SAVED INSIGHTS SCREEN ---',
      name: 'sectionSaved',
      desc: '',
      args: [],
    );
  }

  /// `Saved Insights`
  String get savedTitle {
    return Intl.message(
      'Saved Insights',
      name: 'savedTitle',
      desc: '',
      args: [],
    );
  }

  /// `No Saved Insights Yet`
  String get savedEmptyState {
    return Intl.message(
      'No Saved Insights Yet',
      name: 'savedEmptyState',
      desc: '',
      args: [],
    );
  }

  /// `Save important advice to access it offline later.`
  String get savedEmptySubtitle {
    return Intl.message(
      'Save important advice to access it offline later.',
      name: 'savedEmptySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Deleted successfully`
  String get savedDeleteSuccess {
    return Intl.message(
      'Deleted successfully',
      name: 'savedDeleteSuccess',
      desc: '',
      args: [],
    );
  }

  /// `View Analysis`
  String get savedActionView {
    return Intl.message(
      'View Analysis',
      name: 'savedActionView',
      desc: '',
      args: [],
    );
  }

  /// `Delete Insight?`
  String get savedDialogDeleteTitle {
    return Intl.message(
      'Delete Insight?',
      name: 'savedDialogDeleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone. Are you sure?`
  String get savedDialogDeleteBody {
    return Intl.message(
      'This action cannot be undone. Are you sure?',
      name: 'savedDialogDeleteBody',
      desc: '',
      args: [],
    );
  }

  /// `--- INSIGHT DETAILS SCREEN ---`
  String get sectionDetails {
    return Intl.message(
      '--- INSIGHT DETAILS SCREEN ---',
      name: 'sectionDetails',
      desc: '',
      args: [],
    );
  }

  /// `Insight Details`
  String get detailsTitle {
    return Intl.message(
      'Insight Details',
      name: 'detailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Zoom`
  String get detailsZoom {
    return Intl.message('Zoom', name: 'detailsZoom', desc: '', args: []);
  }

  /// `YOUR QUESTION`
  String get detailsQuestionLabel {
    return Intl.message(
      'YOUR QUESTION',
      name: 'detailsQuestionLabel',
      desc: '',
      args: [],
    );
  }

  /// `AI Analysis`
  String get detailsAnalysisLabel {
    return Intl.message(
      'AI Analysis',
      name: 'detailsAnalysisLabel',
      desc: '',
      args: [],
    );
  }

  /// `Copy Analysis`
  String get detailsActionCopy {
    return Intl.message(
      'Copy Analysis',
      name: 'detailsActionCopy',
      desc: '',
      args: [],
    );
  }

  /// `Analysis copied!`
  String get detailsCopySuccess {
    return Intl.message(
      'Analysis copied!',
      name: 'detailsCopySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Image Preview`
  String get detailsImagePreview {
    return Intl.message(
      'Image Preview',
      name: 'detailsImagePreview',
      desc: '',
      args: [],
    );
  }

  /// `--- LOGIN SCREEN ---`
  String get sectionLogin {
    return Intl.message(
      '--- LOGIN SCREEN ---',
      name: 'sectionLogin',
      desc: '',
      args: [],
    );
  }

  /// `Login to Your Account`
  String get loginTitle {
    return Intl.message(
      'Login to Your Account',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get loginEmailHint {
    return Intl.message(
      'Email Address',
      name: 'loginEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginPasswordHint {
    return Intl.message(
      'Password',
      name: 'loginPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Login successful`
  String get loginSuccess {
    return Intl.message(
      'Login successful',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get loginActionSignIn {
    return Intl.message(
      'Sign In',
      name: 'loginActionSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get loginForgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'loginForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `First Time User? `
  String get loginFirstTimePrompt {
    return Intl.message(
      'First Time User? ',
      name: 'loginFirstTimePrompt',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get loginActionSignUp {
    return Intl.message(
      'Sign Up',
      name: 'loginActionSignUp',
      desc: '',
      args: [],
    );
  }

  /// `--- REGISTER SCREEN ---`
  String get sectionRegister {
    return Intl.message(
      '--- REGISTER SCREEN ---',
      name: 'sectionRegister',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get registerTitle {
    return Intl.message('Sign Up', name: 'registerTitle', desc: '', args: []);
  }

  /// `Create your new account`
  String get registerSubtitle {
    return Intl.message(
      'Create your new account',
      name: 'registerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get registerFirstName {
    return Intl.message(
      'First Name',
      name: 'registerFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Enter first name`
  String get registerFirstNameHint {
    return Intl.message(
      'Enter first name',
      name: 'registerFirstNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get registerLastName {
    return Intl.message(
      'Last Name',
      name: 'registerLastName',
      desc: '',
      args: [],
    );
  }

  /// `Enter last name`
  String get registerLastNameHint {
    return Intl.message(
      'Enter last name',
      name: 'registerLastNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get registerEmail {
    return Intl.message('Email', name: 'registerEmail', desc: '', args: []);
  }

  /// `Enter email`
  String get registerEmailHint {
    return Intl.message(
      'Enter email',
      name: 'registerEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get registerPhone {
    return Intl.message(
      'Phone Number',
      name: 'registerPhone',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone`
  String get registerPhoneHint {
    return Intl.message(
      'Enter phone',
      name: 'registerPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get registerPassword {
    return Intl.message(
      'Password',
      name: 'registerPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must be 6+ chars`
  String get registerPasswordValidation {
    return Intl.message(
      'Password must be 6+ chars',
      name: 'registerPasswordValidation',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get registerConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'registerConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get registerPasswordMatchError {
    return Intl.message(
      'Passwords do not match',
      name: 'registerPasswordMatchError',
      desc: '',
      args: [],
    );
  }

  /// `I accept Terms and Conditions`
  String get registerTermsLabel {
    return Intl.message(
      'I accept Terms and Conditions',
      name: 'registerTermsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please accept terms and conditions`
  String get registerTermsError {
    return Intl.message(
      'Please accept terms and conditions',
      name: 'registerTermsError',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful`
  String get registerSuccess {
    return Intl.message(
      'Registration successful',
      name: 'registerSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerActionButton {
    return Intl.message(
      'Register',
      name: 'registerActionButton',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get registerAlreadyAccountPrompt {
    return Intl.message(
      'Already have an account? ',
      name: 'registerAlreadyAccountPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get registerActionLogin {
    return Intl.message(
      'Login',
      name: 'registerActionLogin',
      desc: '',
      args: [],
    );
  }

  /// `--- PROFILE SCREEN ---`
  String get sectionProfile {
    return Intl.message(
      '--- PROFILE SCREEN ---',
      name: 'sectionProfile',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get profileTitle {
    return Intl.message('My Profile', name: 'profileTitle', desc: '', args: []);
  }

  /// `Error: {err}`
  String profileError(String err) {
    return Intl.message(
      'Error: $err',
      name: 'profileError',
      desc: '',
      args: [err],
    );
  }

  /// `User not found`
  String get profileUserNotFound {
    return Intl.message(
      'User not found',
      name: 'profileUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get profilePhoneLabel {
    return Intl.message(
      'Phone Number',
      name: 'profilePhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get profileEmailLabel {
    return Intl.message(
      'Email Address',
      name: 'profileEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get profileActionEdit {
    return Intl.message(
      'Edit Profile',
      name: 'profileActionEdit',
      desc: '',
      args: [],
    );
  }

  /// `Not set`
  String get profileValueNotSet {
    return Intl.message(
      'Not set',
      name: 'profileValueNotSet',
      desc: '',
      args: [],
    );
  }

  /// `--- EDIT PROFILE SCREEN ---`
  String get sectionEditProfile {
    return Intl.message(
      '--- EDIT PROFILE SCREEN ---',
      name: 'sectionEditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfileTitle {
    return Intl.message(
      'Edit Profile',
      name: 'editProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Photo Library`
  String get editProfilePhotoLibrary {
    return Intl.message(
      'Photo Library',
      name: 'editProfilePhotoLibrary',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get editProfileCamera {
    return Intl.message(
      'Camera',
      name: 'editProfileCamera',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get editProfileSuccess {
    return Intl.message(
      'Profile updated successfully',
      name: 'editProfileSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update profile`
  String get editProfileFailure {
    return Intl.message(
      'Failed to update profile',
      name: 'editProfileFailure',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get editProfileFirstName {
    return Intl.message(
      'First Name',
      name: 'editProfileFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get editProfileLastName {
    return Intl.message(
      'Last Name',
      name: 'editProfileLastName',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get editProfilePhone {
    return Intl.message(
      'Phone Number',
      name: 'editProfilePhone',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get editProfileActionSave {
    return Intl.message(
      'Save Changes',
      name: 'editProfileActionSave',
      desc: '',
      args: [],
    );
  }

  /// `Saving...`
  String get editProfileSaving {
    return Intl.message(
      'Saving...',
      name: 'editProfileSaving',
      desc: '',
      args: [],
    );
  }

  /// `------------------ SAVED SCANS SCREEN --------------------`
  String get sectionSavedScans {
    return Intl.message(
      '------------------ SAVED SCANS SCREEN --------------------',
      name: 'sectionSavedScans',
      desc: '',
      args: [],
    );
  }

  /// `Saved Scans`
  String get scansTitle {
    return Intl.message('Saved Scans', name: 'scansTitle', desc: '', args: []);
  }

  /// `No Saved Scans`
  String get scansEmptyState {
    return Intl.message(
      'No Saved Scans',
      name: 'scansEmptyState',
      desc: '',
      args: [],
    );
  }

  /// `Your plant disease detection scans will appear here for future reference.`
  String get scansEmptySubtitle {
    return Intl.message(
      'Your plant disease detection scans will appear here for future reference.',
      name: 'scansEmptySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Start New Scan`
  String get scansActionStartNew {
    return Intl.message(
      'Start New Scan',
      name: 'scansActionStartNew',
      desc: '',
      args: [],
    );
  }

  /// `Chat History`
  String get historyChatTitle {
    return Intl.message(
      'Chat History',
      name: 'historyChatTitle',
      desc: '',
      args: [],
    );
  }

  /// `Total Scans`
  String get scansTotalCount {
    return Intl.message(
      'Total Scans',
      name: 'scansTotalCount',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =1{1 scan} other{{count} scans}}`
  String scansCount(num count) {
    return Intl.plural(
      count,
      one: '1 scan',
      other: '$count scans',
      name: 'scansCount',
      desc: '',
      args: [count],
    );
  }

  /// `Unknown`
  String get scansUnknown {
    return Intl.message('Unknown', name: 'scansUnknown', desc: '', args: []);
  }

  /// `{percent} confidence`
  String scansConfidenceLabel(String percent) {
    return Intl.message(
      '$percent confidence',
      name: 'scansConfidenceLabel',
      desc: '',
      args: [percent],
    );
  }

  /// `Scan deleted`
  String get scansDeletedSnackbar {
    return Intl.message(
      'Scan deleted',
      name: 'scansDeletedSnackbar',
      desc: '',
      args: [],
    );
  }

  /// `Delete scan`
  String get scansDeleteTooltip {
    return Intl.message(
      'Delete scan',
      name: 'scansDeleteTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Delete Scan`
  String get scansDeleteDialogTitle {
    return Intl.message(
      'Delete Scan',
      name: 'scansDeleteDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this scan result?`
  String get scansDeleteDialogBody {
    return Intl.message(
      'Are you sure you want to delete this scan result?',
      name: 'scansDeleteDialogBody',
      desc: '',
      args: [],
    );
  }

  /// `--- CONVERSATION HISTORY ---`
  String get sectionHistory {
    return Intl.message(
      '--- CONVERSATION HISTORY ---',
      name: 'sectionHistory',
      desc: '',
      args: [],
    );
  }

  /// `Conversation History`
  String get historyTitle {
    return Intl.message(
      'Conversation History',
      name: 'historyTitle',
      desc: '',
      args: [],
    );
  }

  /// `No history yet`
  String get historyEmpty {
    return Intl.message(
      'No history yet',
      name: 'historyEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Untitled Conversation`
  String get historyUntitled {
    return Intl.message(
      'Untitled Conversation',
      name: 'historyUntitled',
      desc: '',
      args: [],
    );
  }

  /// `Conversation deleted.`
  String get historyDeleted {
    return Intl.message(
      'Conversation deleted.',
      name: 'historyDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Unknown date`
  String get historyUnknownDate {
    return Intl.message(
      'Unknown date',
      name: 'historyUnknownDate',
      desc: '',
      args: [],
    );
  }

  /// `Start a conversation first.`
  String get mainStartConversationFirst {
    return Intl.message(
      'Start a conversation first.',
      name: 'mainStartConversationFirst',
      desc: '',
      args: [],
    );
  }

  /// `Chat saved & cleared.`
  String get mainChatSavedAndCleared {
    return Intl.message(
      'Chat saved & cleared.',
      name: 'mainChatSavedAndCleared',
      desc: '',
      args: [],
    );
  }

  /// `Conversation loaded`
  String get historyConversationLoaded {
    return Intl.message(
      'Conversation loaded',
      name: 'historyConversationLoaded',
      desc: '',
      args: [],
    );
  }

  /// `Crop`
  String get commonCrop {
    return Intl.message('Crop', name: 'commonCrop', desc: '', args: []);
  }

  /// `--- FORGOT PASSWORD ---`
  String get sectionForgotPassword {
    return Intl.message(
      '--- FORGOT PASSWORD ---',
      name: 'sectionForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get forgotPasswordTitle {
    return Intl.message(
      'Reset Password',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address and we will send you a link to reset your password.`
  String get forgotPasswordSubtitle {
    return Intl.message(
      'Enter your email address and we will send you a link to reset your password.',
      name: 'forgotPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get forgotPasswordEmailLabel {
    return Intl.message(
      'Email Address',
      name: 'forgotPasswordEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get forgotPasswordEmailEmpty {
    return Intl.message(
      'Please enter your email',
      name: 'forgotPasswordEmailEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get forgotPasswordEmailInvalid {
    return Intl.message(
      'Please enter a valid email',
      name: 'forgotPasswordEmailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Send Reset Link`
  String get forgotPasswordActionSend {
    return Intl.message(
      'Send Reset Link',
      name: 'forgotPasswordActionSend',
      desc: '',
      args: [],
    );
  }

  /// `Password reset link sent! Check your email.`
  String get forgotPasswordSuccess {
    return Intl.message(
      'Password reset link sent! Check your email.',
      name: 'forgotPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get forgotPasswordErrorGeneral {
    return Intl.message(
      'An error occurred',
      name: 'forgotPasswordErrorGeneral',
      desc: '',
      args: [],
    );
  }

  /// `No user found with this email.`
  String get forgotPasswordErrorNoUser {
    return Intl.message(
      'No user found with this email.',
      name: 'forgotPasswordErrorNoUser',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format.`
  String get forgotPasswordErrorInvalidFormat {
    return Intl.message(
      'Invalid email format.',
      name: 'forgotPasswordErrorInvalidFormat',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again.`
  String get forgotPasswordErrorUnexpected {
    return Intl.message(
      'An unexpected error occurred. Please try again.',
      name: 'forgotPasswordErrorUnexpected',
      desc: '',
      args: [],
    );
  }

  /// `--- DETECTION RESULT SCREEN ---`
  String get sectionDetection {
    return Intl.message(
      '--- DETECTION RESULT SCREEN ---',
      name: 'sectionDetection',
      desc: '',
      args: [],
    );
  }

  /// `Analysis Result`
  String get detTitle {
    return Intl.message(
      'Analysis Result',
      name: 'detTitle',
      desc: '',
      args: [],
    );
  }

  /// `Remove from saved`
  String get detActionRemove {
    return Intl.message(
      'Remove from saved',
      name: 'detActionRemove',
      desc: '',
      args: [],
    );
  }

  /// `Save result`
  String get detActionSave {
    return Intl.message(
      'Save result',
      name: 'detActionSave',
      desc: '',
      args: [],
    );
  }

  /// `Result removed from saved scans.`
  String get detMsgRemoved {
    return Intl.message(
      'Result removed from saved scans.',
      name: 'detMsgRemoved',
      desc: '',
      args: [],
    );
  }

  /// `Result saved successfully!`
  String get detMsgSaved {
    return Intl.message(
      'Result saved successfully!',
      name: 'detMsgSaved',
      desc: '',
      args: [],
    );
  }

  /// `Healthy`
  String get detStatusHealthy {
    return Intl.message(
      'Healthy',
      name: 'detStatusHealthy',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get detStatusUnknown {
    return Intl.message(
      'Unknown',
      name: 'detStatusUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Severity: `
  String get detLabelSeverity {
    return Intl.message(
      'Severity: ',
      name: 'detLabelSeverity',
      desc: '',
      args: [],
    );
  }

  /// `Affected Area: `
  String get detLabelAffectedArea {
    return Intl.message(
      'Affected Area: ',
      name: 'detLabelAffectedArea',
      desc: '',
      args: [],
    );
  }

  /// `--- VIDEO RESOURCES ---`
  String get sectionVideos {
    return Intl.message(
      '--- VIDEO RESOURCES ---',
      name: 'sectionVideos',
      desc: '',
      args: [],
    );
  }

  /// `{cropName} treatment for farmers agriculture`
  String videoSearchQuery(String cropName) {
    return Intl.message(
      '$cropName treatment for farmers agriculture',
      name: 'videoSearchQuery',
      desc: '',
      args: [cropName],
    );
  }

  /// `Video Resources`
  String get videoTitle {
    return Intl.message(
      'Video Resources',
      name: 'videoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Refresh videos`
  String get videoRefreshTooltip {
    return Intl.message(
      'Refresh videos',
      name: 'videoRefreshTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Loading helpful videos...`
  String get videoLoading {
    return Intl.message(
      'Loading helpful videos...',
      name: 'videoLoading',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load videos`
  String get videoErrorLoad {
    return Intl.message(
      'Failed to load videos',
      name: 'videoErrorLoad',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get videoActionTryAgain {
    return Intl.message(
      'Try Again',
      name: 'videoActionTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `No videos found`
  String get videoEmptyState {
    return Intl.message(
      'No videos found',
      name: 'videoEmptyState',
      desc: '',
      args: [],
    );
  }

  /// `Try searching with different keywords`
  String get videoEmptySubtitle {
    return Intl.message(
      'Try searching with different keywords',
      name: 'videoEmptySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Swipe for more videos →`
  String get videoSwipeHint {
    return Intl.message(
      'Swipe for more videos →',
      name: 'videoSwipeHint',
      desc: '',
      args: [],
    );
  }

  /// `--- ERROR DIALOGS ---`
  String get sectionErrors {
    return Intl.message(
      '--- ERROR DIALOGS ---',
      name: 'sectionErrors',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Image`
  String get errorInvalidImageTitle {
    return Intl.message(
      'Invalid Image',
      name: 'errorInvalidImageTitle',
      desc: '',
      args: [],
    );
  }

  /// `We could not identify a supported crop in this image.\n\nPlease upload a clear photo of:\n• Wheat, Potato, Pepper\n• Orange, Maize, or Apple`
  String get errorInvalidImageBody {
    return Intl.message(
      'We could not identify a supported crop in this image.\n\nPlease upload a clear photo of:\n• Wheat, Potato, Pepper\n• Orange, Maize, or Apple',
      name: 'errorInvalidImageBody',
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
