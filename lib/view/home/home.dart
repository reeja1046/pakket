import 'package:flutter/material.dart';
import 'package:pakket/const/color.dart';
import 'package:pakket/model/allcategory.dart';
import 'package:pakket/model/product.dart';
import 'package:pakket/model/trending.dart';
import 'package:pakket/services/category.dart';
import 'package:pakket/services/product.dart';
import 'package:pakket/services/trending.dart';
import 'package:pakket/view/allgrocery.dart';
import 'package:pakket/view/home/widget.dart';
import 'package:pakket/view/search.dart';

int selectedCategoryIndex = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Product>> _trendingProducts;
  Future<List<Category>>? _categoriesFuture;
  Future<List<CategoryProduct>>? _selectedCategoryProducts;

  @override
  void initState() {
    super.initState();
    _trendingProducts = fetchTrendingProducts();
    _categoriesFuture = fetchCategories();

    _categoriesFuture!.then((categories) {
      if (categories.isNotEmpty) {
        final defaultCategory = categories[selectedCategoryIndex];
        setState(() {
          if (defaultCategory.name.toLowerCase() == 'all items') {
            _selectedCategoryProducts = fetchRandomProducts(8);
          } else {
            _selectedCategoryProducts =
                fetchProductsByCategory(defaultCategory.id);
          }
        });
      }
    });
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
              // Yellow background section
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x66CAD980), // 40% opacity
                      Color(0x21CCDA86), // 13% opacity
                      Color(0xFFFFFFFF), // full white
                    ],
                    stops: [
                      0.0,
                      0.95,
                      0.100,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                      child: buildHeader(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: TextFormField(
                                readOnly: true,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchDetails()),
                                  );
                                },
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: CustomColors.baseColor,
                                        width: 2),
                                  ),
                                  hintText: 'Search',
                                  prefixIcon: Icon(Icons.search_outlined),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            height: 45,
                            width: 50,
                            decoration: BoxDecoration(
                              color: CustomColors.baseColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.tune_rounded,
                                  color: Colors.white, size: 22),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Start of scroll card and rest of the white background UI
                    showScrollCard(),
                  ],
                ),
              ),

              FutureBuilder<List<Category>>(
                future: _categoriesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No categories found"));
                  }

                  final categories = snapshot.data!;
                  final selectedCategoryName =
                      categories[selectedCategoryIndex].name;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              bool isSelected = selectedCategoryIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategoryIndex = index;
                                    if (category.name.toLowerCase() ==
                                        'all items') {
                                      _selectedCategoryProducts =
                                          fetchRandomProducts(8);
                                    } else {
                                      _selectedCategoryProducts =
                                          fetchProductsByCategory(category.id);
                                    }
                                  });
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.03,
                                        vertical: screenWidth * 0.015,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.01),
                                      decoration: isSelected
                                          ? BoxDecoration(
                                              color: Colors.orange,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            )
                                          : null,
                                      child: Image.network(
                                        category.iconUrl,
                                        width: screenWidth * 0.1,
                                        height: screenWidth * 0.1,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(height: screenWidth * 0.01),
                                    Text(
                                      category.name,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.035,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    if (isSelected)
                                      Container(
                                        width: screenWidth * 0.12,
                                        height: 3,
                                        color: Colors.orange,
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
                          selectedCategoryName,
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AllGroceryItems(),
                              ),
                            );
                          },
                        ),
                      ),
                      FutureBuilder<List<CategoryProduct>>(
                        future: _selectedCategoryProducts,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No products found.'));
                          }

                          final products = snapshot.data!;
                          return buildProductGrid(products);
                        },
                      )
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                child: SizedBox(
                  width: screenWidth,
                  height: 240,
                  child:
                      Image.asset('assets/reward-Ad.png', fit: BoxFit.contain),
                ),
              ),
              SizedBox(height: 10),
              showTrendingProduct(_trendingProducts),
            ],
          ),
        ),
      ),
    );
  }
}
