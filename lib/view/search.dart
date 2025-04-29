import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pakket/const/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchDetails extends StatefulWidget {
  const SearchDetails({super.key});

  @override
  State<SearchDetails> createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAllProducts(); // Load all products initially
  }

  void fetchAllProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    setState(() => isLoading = true);

    try {
      final response = await http.get(
        Uri.parse('https://pakket-dev.vercel.app/api/app/product'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          searchResults = data['data'];
        });
      } else {
        debugPrint("Failed to fetch all products");
      }
    } catch (e) {
      debugPrint("Error loading all products: $e");
    }

    setState(() => isLoading = false);
  }

  void searchProducts(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (query.isEmpty) {
      fetchAllProducts(); // fallback to all products
      return;
    }

    setState(() => isLoading = true);

    try {
      final url = Uri.parse(
          'https://pakket-dev.vercel.app/api/app/search?q=${Uri.encodeQueryComponent(query)}');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          searchResults = data['data'];
        });
      } else {
        debugPrint("Search request failed");
      }
    } catch (e) {
      debugPrint("Search error: $e");
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 245, 245),
        title: const Text(
          'Search in detail',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        controller: _searchController,
                        onChanged: searchProducts,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: CustomColors.baseColor, width: 2),
                          ),
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search_outlined),
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
                      onPressed: () {
                        searchProducts(_searchController.text);
                      },
                      icon: const Icon(Icons.tune_rounded,
                          color: Colors.white, size: 22),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              if (_searchController.text.isNotEmpty)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      _searchController.clear();
                      fetchAllProducts();
                    },
                    child: const Text("Clear Search"),
                  ),
                ),

              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (searchResults.isEmpty)
                const Center(child: Text("No products found"))
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchResults.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final product = searchResults[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: CustomColors.basecontainer,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.network(
                                    product['thumbnail'] ?? '',
                                    height: 80,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        const Icon(Icons.image_not_supported),
                                  ),
                                ),
                              ),
                              Text(
                                product['title'] ?? 'No title',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              const Divider(indent: 10, endIndent: 10),
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      product['weight'] ?? '',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black54),
                                    ),
                                    const VerticalDivider(),
                                    Text(
                                      product['price']?.toString() ?? '',
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 30,
                                width: 80,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomColors.baseColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    // TODO: Handle add to cart
                                  },
                                  child: const Text('Add',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
