import 'package:flutter/material.dart';
import 'package:pakket/const/appbar.dart';
import 'package:pakket/const/color.dart';
import 'package:pakket/const/items.dart';

class AllGroceryItems extends StatelessWidget {
  AllGroceryItems({super.key});

  final ScrollController categoryScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 245, 245),
      appBar: buildGroceryAppBar(context, "All grocery items"),
      body: Row(
        children: [
          // Left Section - Product Categoriesscrolling (Scrollable)
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Theme(
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(CustomColors.baseColor),
                  minThumbLength: 30, // Smaller Scrollbar Length
                  thickness: WidgetStateProperty.all(3),
                  radius: const Radius.circular(5),
                ),
              ),
              child: Scrollbar(
                controller: categoryScrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: categoryScrollController,
                  child: Column(
                    children: grocerycategories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: CustomColors.basecontainer),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        category['image']!,
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Text(
                              category['name']!,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),

          // Right Section - Product Grid
          Expanded(
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.6, // Adjusted for Better Responsiveness
                ),
                itemCount: groceryproducts.length,
                itemBuilder: (context, index) {
                  final product = groceryproducts[index];

                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: CustomColors.basecontainer),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                product['image']!,
                                height: 80,
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Text(
                            product['name']!,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const Divider(indent: 10, endIndent: 10),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  product['weight']!,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                                VerticalDivider(),
                                Text(
                                  product['price']!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
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
                              onPressed: () {},
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
          ),
        ],
      ),
    );
  }
}
