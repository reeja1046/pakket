import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildHeader(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Image.asset(
            'assets/pakket_logo.png',
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Column(
            children: [
              Text(
                'PAKKET',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.06, // Responsive size
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic, // Slight italics
                  letterSpacing: 3.0,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3), // Light shadow
                      offset: Offset(2, 2), // Slight shadow position
                      blurRadius: 4, // Soft blur
                    ),
                  ],
                ),
              ),
              Text(
                'ALL IN ONE',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.025, // Smaller text
                  fontWeight: FontWeight.w500, // Normal weight
                  fontStyle: FontStyle.italic, // Slight italics
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            child: Image.asset('assets/profile icon.png'),
          )
        ],
      ),
      SizedBox(height: 10),
      Text(
        'Your Location',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Row(
        children: [
          const Text(
            'PVS Green Valley, Chalakunnu, Kannur',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          SizedBox(width: 5),
          Icon(Icons.location_on_outlined),
        ],
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget scrollCard(BuildContext context) {
  final PageController controller = PageController(
    initialPage: 1,
    viewportFraction:
        0.85, // This allows the side cards to be partially visible
  );

  final List<String> images = [
    'assets/Milk.png',
    'assets/homebanner.png',
    'assets/Milk.png',
  ];

  return SizedBox(
    height: 240,
    child: PageView.builder(
      controller: controller,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(images[index], fit: BoxFit.contain),
          ),
        );
      },
    ),
  );
}

Widget buildCategoryHeader(
    BuildContext context, String title, VoidCallback onSeeAllPressed) {
  double screenWidth = MediaQuery.of(context).size.width;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: screenWidth * 0.045, // Responsive font size
          fontWeight: FontWeight.bold,
        ),
      ),
      GestureDetector(
        onTap: onSeeAllPressed,
        child: Text(
          'See All',
          style: TextStyle(
            fontSize: screenWidth * 0.035, // Responsive font size
            color: Colors.orange,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
