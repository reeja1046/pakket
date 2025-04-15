import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pakket/const/color.dart';
import 'package:pakket/model/banner.dart';
import 'package:pakket/model/trending.dart';
import 'package:pakket/services/banner.dart';

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

Widget scrollCard(BuildContext context, List<HeroBanner> banners) {
  final PageController controller = PageController(
    initialPage: 1,
    viewportFraction: 0.85,
  );

  return SizedBox(
    height: 240,
    child: PageView.builder(
      controller: controller,
      itemCount: banners.length,
      itemBuilder: (context, index) {
        final banner = banners[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              banner.url,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  Center(child: Icon(Icons.error)),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
            ),
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

Widget showScrollCard() {
  return FutureBuilder<List<HeroBanner>>(
    future: fetchHeroBanners(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return SizedBox(
          height: 240,
          child: Center(child: CircularProgressIndicator()),
        );
      } else if (snapshot.hasError) {
        return SizedBox(
          height: 240,
          child: Center(child: Text('Failed to load banners')),
        );
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return SizedBox(
          height: 240,
          child: Center(child: Text('No banners available')),
        );
      }

      return scrollCard(context, snapshot.data!);
    },
  );
}

Widget showTrendingProduct(trendingProducts) {
  return FutureBuilder<List<Product>>(
    future: trendingProducts,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No trending products available'));
      }

      final products = snapshot.data!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14.0),
            child: buildCategoryHeader(
              context,
              'Trending Offers',
              () {},
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  CustomColors.basecontainer,
                ],
              ),
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(products.length, (index) {
                      final product = products[index];
                      final option = product.options.first;

                      double screenWidth = MediaQuery.of(context).size.width;
                      double cardWidth = screenWidth * 0.4;
                      double imageHeight = screenWidth * 0.25;
                      double fontSize = screenWidth * 0.035;

                      return Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Container(
                          margin: EdgeInsets.only(right: screenWidth * 0.025),
                          width: cardWidth,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color.fromARGB(
                                            255, 237, 237, 237),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      width: screenWidth,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.network(
                                          product.thumbnail,
                                          height: imageHeight,
                                          width: double.infinity,
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(Icons.broken_image),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenWidth * 0.02),
                                  Text(
                                    product.title,
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: screenWidth * 0.01),
                                  Text(
                                    option.unit,
                                    style: TextStyle(
                                      fontSize: fontSize * 0.9,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rs.${option.offerPrice.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: fontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        width: 60,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: CustomColors.baseColor,
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Add',
                                            style: TextStyle(
                                              fontSize: fontSize * 0.9,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      );
    },
  );
}
