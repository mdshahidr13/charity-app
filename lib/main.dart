import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/add_client_screen.dart';
import 'screens/my_clients_screen.dart';
import 'package:provider/provider.dart';
import 'services/client_provider.dart';
import 'screens/add_activity_screen.dart';
import 'screens/my_activities_screen.dart';
import 'screens/ocr_prescription_screen.dart';
import 'screens/review_extracted_data_screen.dart';
import 'services/activity_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (_) => ActivityProvider()),
      ],
      child: const AngelMedApp(),
    ),
  );
}

class AngelMedApp extends StatelessWidget {
  const AngelMedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AngelMed',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.light(
          primary: Colors.black,
          secondary: Color(0xFF660066), // Purple Dreamer accent
          background: Colors.white,
          surface: Colors.grey[100]!,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF660066)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF660066), width: 2),
          ),
          labelStyle: const TextStyle(color: Colors.black54),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF660066),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF660066),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/clients/add': (context) => const AddClientScreen(),
        '/clients/list': (context) => const MyClientsScreen(),
        '/activities/add': (context) => const AddActivityScreen(),
        '/activities/list': (context) => const MyActivitiesScreen(),
        '/prescriptions/ocr': (context) => const OCRPrescriptionScreen(),
        '/prescriptions/review': (context) => const ReviewExtractedDataScreen(),
      },
    );
  }
}

// Placeholder screens
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('AngelMed Splash', style: TextStyle(fontSize: 24))),
    );
  }
}
