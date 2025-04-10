import 'package:flutter/material.dart';
import 'package:pakket/view/search.dart';

AppBar buildGroceryAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: const Color.fromARGB(255, 250, 245, 245),
    title: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SearchDetails()),
          );
        },
      ),
      const SizedBox(width: 10),
    ],
  );
}
