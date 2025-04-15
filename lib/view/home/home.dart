import 'package:flutter/material.dart';
import 'package:pakket/const/color.dart';
import 'package:pakket/model/allcategory.dart';
import 'package:pakket/model/trending.dart';
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
              showScrollCard(),
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
                  final selectedCategoryName =
                      categories[selectedCategoryIndex].name;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
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
                      
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
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
              showTrendingProduct(_trendingProducts),
            ],
          ),
        ),
      ),
    );
  }
}
