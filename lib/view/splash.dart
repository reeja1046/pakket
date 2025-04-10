import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pakket/view/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Navigation timer
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _initializeSplash();
  }

  @override
  void dispose() {
    _navigationTimer?.cancel(); // Prevent memory leaks
    super.dispose();
  }

  void _initializeSplash() {
    _navigationTimer = Timer(
      const Duration(seconds: 4),
      () => _navigateToOnboarding(),
    );
  }

  void _navigateToOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            const SizedBox(height: 40),
            _buildSplashImage(),
            _buildAppTitle(screenWidth, textScaleFactor),
            _buildSubtitle(screenWidth, textScaleFactor),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/pakket_logo.png',
      errorBuilder: (_, __, ___) => const Icon(Icons.shopping_bag), // Fallback
    );
  }

  Widget _buildSplashImage() {
    return Image.asset(
      'assets/splash.png',
      errorBuilder: (_, __, ___) => const Icon(Icons.image), // Fallback
    );
  }

  Widget _buildAppTitle(double screenWidth, double textScaleFactor) {
    return Text(
      'PAKKET',
      style: GoogleFonts.poppins(
        fontSize: screenWidth * 0.15 * textScaleFactor,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        letterSpacing: 12.0,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle(double screenWidth, double textScaleFactor) {
    return Text(
      'ALL IN ONE',
      style: GoogleFonts.poppins(
        fontSize: screenWidth * 0.05 * textScaleFactor,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
