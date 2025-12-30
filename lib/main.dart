import 'package:farmwise_ai/auth/auth_repository.dart';
import 'package:farmwise_ai/auth/intro_screen.dart';
import 'package:farmwise_ai/auth/login_screen.dart';
import 'package:farmwise_ai/language_classes/language_constants.dart';
import 'package:farmwise_ai/providers/tts_provider.dart';
import 'package:farmwise_ai/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart' as provider;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);
  await Hive.openBox('detection_results');
  await Hive.openBox("model_answers");
  await dotenv.load(fileName: ".env");

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // (for Riverpod) AND MultiProvider (for your existing TTS)
  runApp(
    const ProviderScope(
      child: AppWrapper(),
    ),
  );
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(create: (context) => TtsProvider()),
      ],
      child: const MyApp(),
    );
  }
}

final introSeenProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isIntroSeen') ?? false;
});

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends ConsumerState<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final introSeenState = ref.watch(introSeenProvider);

    return MaterialApp(
      title: 'FarmWise AI',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: introSeenState.when(
        data: (isIntroSeen) {
          if (!isIntroSeen) {
            return const IntroScreen();
          }

          return authState.when(
            data: (user) {
              if (user != null) {
                return const MainScreen();
              } else {
                return const LoginScreen();
              }
            },
            loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (e, stack) => Scaffold(
                body: Center(
              child: Text("Auth Error: $e"),
            )),
          );
        },
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        error: (e, stack) => Scaffold(
          body: Center(child: Text("Intro Error: $e")),
        ),
      ),
    );
  }
}
