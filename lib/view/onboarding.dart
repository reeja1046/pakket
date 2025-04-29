import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pakket/const/color.dart';
import 'package:pakket/view/auth/signup.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  void nextPage() {
    if (currentPage < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // If it's the last page, navigate to SignUpScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Skip',
                    style: GoogleFonts.poppins(),
                  ),
                  SizedBox(width: 7),
                  CircleAvatar(
                    backgroundColor: CustomColors.baseColor,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 18),
                ],
              ),

              // Modified image container with reduced height
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Image.asset(
                  'assets/onboarding.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 15,
            right: 15,
            child: Image.asset('assets/Rectangle.png'),
          ),
          Positioned(
            bottom: 45,
            left: 15,
            right: 15,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: JumpingDotEffect(
                    activeDotColor: Colors.white,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
                SizedBox(height: 14),
                SizedBox(
                  height: 120,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      _buildPage(
                        'Buy Groceries Easily\nwith Us',
                        'It is a long established fact that a reader\nwill be distracted by the readable',
                      ),
                      _buildPage(
                        'Get Fresh Fruits and\nVegetables',
                        'Order fresh fruits and vegetables\nat your convenience.',
                      ),
                      _buildPage(
                        'Fast & Secure Delivery',
                        'Your groceries delivered on time\nwith safe payment options.',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: IconButton(
                    onPressed: nextPage,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: CustomColors.baseColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPage(String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
