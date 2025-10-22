import 'package:flutter/material.dart';
import 'home_screen.dart';
void main() { runApp(const IcspiApp()); }
class IcspiApp extends StatelessWidget {
  const IcspiApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICSPI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0B132B),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1D2671),
          primary: const Color(0xFF1D2671),
          secondary: const Color(0xFFFFD700),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}