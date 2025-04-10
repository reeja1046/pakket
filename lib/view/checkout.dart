// import 'package:flutter/material.dart';
// import 'package:pakket/const/color.dart';

// final List<Map<String, String>> products = [
//   {
//     'image': 'assets/image 1577.png',
//     'name': 'Tomatoes',
//     'weight': '1 kg',
//     'price': 'Rs.30'
//   },
//   {
//     'image': 'assets/image 1577.png',
//     'name': 'Bananas',
//     'weight': '1 Dozen',
//     'price': 'Rs.50'
//   },
//   {
//     'image': 'assets/image 1577.png',
//     'name': 'Milk',
//     'weight': '1 L',
//     'price': 'Rs.60'
//   },
//   {
//     'image': 'assets/image 1577.png',
//     'name': 'Chips',
//     'weight': '150 g',
//     'price': 'Rs.40'
//   },
// ];

// class CheckOutDetails extends StatelessWidget {
//   const CheckOutDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search in Detail'),
//          leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SafeArea(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: SizedBox(
//                     height: 56,
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Search',
//                         prefixIcon: Icon(Icons.search_outlined),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 15),
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: CustomColors.baseColor,
//                   ),
//                   height: 54,
//                   width: 56,
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Recent Searches!',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 buildContainer('1kg Wheat'),
//                 buildContainer('Ashirvaad'),
//                 buildContainer('Wheat Flour'),
//               ],
//             ),
//             SizedBox(height: 8),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(3),
//               ),
//               child: Text(
//                 '500gm atta',
//                 style: const TextStyle(color: Colors.black),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 color: Colors.grey[100],
//                 child: GridView.builder(
//                   padding: const EdgeInsets.all(12),
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     childAspectRatio: 0.75,
//                   ),
//                   itemCount: products.length,
//                   itemBuilder: (context, index) {
//                     final product = products[index];

//                     return Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white70,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             product['image']!,
//                             height: 100,
//                             width: double.infinity,
//                             fit: BoxFit.contain,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             product['name']!,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Divider(indent: 20, endIndent: 20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               IntrinsicHeight(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Text(product['weight']!),
//                                     VerticalDivider(),
//                                     Text(product['price']!)
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Container(
//                             height: 30,
//                             width: 80,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: CustomColors.baseColor,
//                             ),
//                             child: const Center(
//                               child: Text(
//                                 'Add',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }

// Widget buildContainer(String text) {
//   return Container(
//     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//     decoration: BoxDecoration(
//       color: Colors.grey[300],
//       borderRadius: BorderRadius.circular(3),
//     ),
//     child: Text(
//       text,
//       style: const TextStyle(color: Colors.black),
//     ),
//   );
// }
