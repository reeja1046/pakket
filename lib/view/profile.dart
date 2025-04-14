import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

  // Best Deals List without background color
                    // SizedBox(
                    //   height: 130,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: ListView.separated(
                    //     separatorBuilder: (context, index) =>
                    //         const Divider(thickness: 1),
                    //     itemCount: quantities.length,
                    //     itemBuilder: (context, index) {
                    //       return Row(
                    //         children: [
                    //           Image.asset(
                    //             'assets/image 1576.png',
                    //             fit: BoxFit.cover,
                    //             width: 50,
                    //             height: 50,
                    //           ),
                    //           const SizedBox(width: 8),
                    //           Expanded(
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Text(
                    //                   'Product ${index + 1}',
                    //                   style: const TextStyle(
                    //                       fontWeight: FontWeight.bold),
                    //                 ),
                    //                 const Text('₹100'),
                    //               ],
                    //             ),
                    //           ),
                    //           Row(
                    //             children: [
                    //               IconButton(
                    //                 icon: const Icon(Icons.remove, size: 18),
                    //                 onPressed: () {
                    //                   setState(() {
                    //                     if (quantities[index] > 1) {
                    //                       quantities[index]--;
                    //                     }
                    //                   });
                    //                 },
                    //               ),
                    //               Text(
                    //                 '${quantities[index]}',
                    //                 style: const TextStyle(fontSize: 16),
                    //               ),
                    //               IconButton(
                    //                 icon: const Icon(Icons.add, size: 18),
                    //                 onPressed: () {
                    //                   setState(() {
                    //                     quantities[index]++;
                    //                   });
                    //                 },
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),