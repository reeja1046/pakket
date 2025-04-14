import 'package:flutter/material.dart';
import 'package:pakket/const/color.dart';
import 'package:pakket/const/items.dart';
import 'package:pakket/model/allcategory.dart';
import 'package:pakket/model/banner.dart';
import 'package:pakket/model/trending.dart';
import 'package:pakket/services/banner.dart';
import 'package:pakket/services/category.dart';
import 'package:pakket/services/trending.dart';
import 'package:pakket/view/allgrocery.dart';
import 'package:pakket/view/home/widget.dart';

int selectedCategoryIndex = 0; // Track selected category

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _trendingProducts;

  @override
  void initState() {
    super.initState();
    _trendingProducts = fetchTrendingProducts();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                child: Column(
                  children: [
                    buildHeader(context),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Search',
                                prefixIcon: Icon(Icons.search_outlined),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: CustomColors.baseColor,
                          ),
                          height: 40,
                          width: 45,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.tune_rounded,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              FutureBuilder<List<HeroBanner>>(
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.12, // Responsive height
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categorySection.length,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedCategoryIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategoryIndex =
                                index; // Update selected category
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    screenWidth * 0.03, // Responsive padding
                                vertical: screenWidth * 0.015,
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.01),
                              decoration: isSelected
                                  ? BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    )
                                  : null, // Remove decoration for unselected items
                              child: Image.asset(
                                categorySection[index]
                                    ['image']!, // Display category image
                                width:
                                    screenWidth * 0.1, // Responsive image size
                                height: screenWidth * 0.1,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                                height:
                                    screenWidth * 0.01), // Responsive spacing
                            Text(
                              categorySection[index]
                                  ['name']!, // Display category label
                              style: TextStyle(
                                fontSize:
                                    screenWidth * 0.035, // Responsive text size
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            if (isSelected)
                              Container(
                                width: screenWidth *
                                    0.12, // Responsive underline width
                                height: 3,
                                color: Colors
                                    .orange, // Underline for selected item
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: buildCategoryHeader(
                  context,
                  'Shop By Categories',
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AllGroceryItems(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<Category>>(
                future: fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No categories found"));
                  }

                  final categories = snapshot.data!;
                  final screenWidth = MediaQuery.of(context).size.width;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: SizedBox(
                      height: (categories.length / 4).ceil() * 120,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: CustomColors.basecontainer,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      height: 70,
                                      width: 68,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              NetworkImage(category.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category.name,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.036,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                child: SizedBox(
                    width: screenWidth,
                    height: 240,
                    child: Image.asset('assets/reward-Ad.png',
                        fit: BoxFit.contain)),
              ),
              SizedBox(height: 10),
              FutureBuilder<List<Product>>(
                future: _trendingProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No trending products available'));
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
                                children:
                                    List.generate(products.length, (index) {
                                  final product = products[index];
                                  final option = product.options.first;

                                  double screenWidth =
                                      MediaQuery.of(context).size.width;
                                  double cardWidth = screenWidth * 0.4;
                                  double imageHeight = screenWidth * 0.25;
                                  double fontSize = screenWidth * 0.035;

                                  return Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: screenWidth * 0.025),
                                      width: cardWidth,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              screenWidth * 0.02),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: const Color.fromARGB(
                                                        255, 237, 237, 237),
                                                  ),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.15,
                                                  width: screenWidth,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Image.network(
                                                      product.thumbnail,
                                                      height: imageHeight,
                                                      width: double.infinity,
                                                      fit: BoxFit.contain,
                                                      errorBuilder: (_, __,
                                                              ___) =>
                                                          const Icon(Icons
                                                              .broken_image),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: screenWidth * 0.02),
                                              Text(
                                                product.title,
                                                style: TextStyle(
                                                  fontSize: fontSize,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                  height: screenWidth * 0.01),
                                              Text(
                                                option.unit,
                                                style: TextStyle(
                                                  fontSize: fontSize * 0.9,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Rs.${option.offerPrice.toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                      fontSize: fontSize,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 60,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: CustomColors
                                                          .baseColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Add',
                                                        style: TextStyle(
                                                          fontSize:
                                                              fontSize * 0.9,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
