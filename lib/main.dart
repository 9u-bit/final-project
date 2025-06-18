import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // flutter pub add google_fonts
import 'package:seseart/ui/logged_in_admin.dart';
import 'package:seseart/ui/logged_in_customer.dart';
import 'package:seseart/ui/login_customer.dart';
import 'package:seseart/ui/signup_customer.dart';
import 'ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'S.ESE.ART',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginCustomer(),
        '/signup': (context) => const SignupCustomer(),
        '/logged_in_customer': (context) => const LoggedInCustomer(),
        '/logged_in_admin': (context) => const LoggedInAdmin(),
      }
    );
  }
}