import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pakket/const/color.dart';
import 'package:pakket/view/cart.dart';
import 'package:pakket/view/checkout.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 245, 245),
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          _buildProductDetails(context),
          // _buildBottomBar(context),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 250, 245, 245),
      title: const Text(
        'Product Detail',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageCarousel(),
            const SizedBox(height: 20),
            _buildProductTitle(),
            const SizedBox(height: 8),
            _buildProductDescription(),
            const SizedBox(height: 25),
            _buildPriceAndOption(),
            const SizedBox(height: 60),
            _buildBestDealHeader(),
            const SizedBox(height: 12),
            _buildBestDealItems(context),
            const SizedBox(height: 80), // Extra space for bottom button
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: PageView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Image.asset(
                  'assets/home-surf.png',
                  fit: BoxFit.contain,
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductTitle() {
    return Text(
      'Product Title',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
    );
  }

  Widget _buildProductDescription() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: Colors.black, height: 1.5),
        children: [
          TextSpan(
            text: showMore
                ? 'This is the product description. It provides detailed information about the product. Additional details about the product, including its features, benefits, and usage instructions. '
                : 'This is the product description. It provides detailed information about the product. ',
          ),
          TextSpan(
            text: showMore ? 'Show Less' : 'More',
            style: const TextStyle(color: Colors.orange),
            recognizer: TapGestureRecognizer()
              ..onTap = () => setState(() => showMore = !showMore),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Text(
              'Rs.250/-',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Text(
              'Rs.300/-',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.black,
                decorationThickness: 2,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              backgroundColor: Colors.white,
              builder: (context) => _buildOptionBottomSheet(),
            );
          },
          child: Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: CustomColors.baseColor,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      '2 options',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 4),
                    Transform.rotate(
                      angle: 1.57, // 90 degrees (π/2 radians)
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildOptionBottomSheet() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(Icons.drag_handle, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          const Text(
            'Choose Quantity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 2, // Example with 2 options
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset('assets/home-surf.png', height: 40),
                title: Text('Surf excel'),
                subtitle: IntrinsicHeight(
                  child: Row(
                    children: [
                      Text(
                        '500 ml',
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                      ),
                      VerticalDivider(),
                      Text(
                        'Rs.79',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text('1'),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildBestDealHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Best Deal',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          'See All',
          style: TextStyle(color: CustomColors.baseColor),
        ),
      ],
    );
  }

  Widget _buildBestDealItems(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDealItem(),
        _buildDealItem(),
      ],
    );
  }

  Widget _buildDealItem() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 250, 245, 245),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('500 ml'),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/home-surf.png',
                  height: 80,
                  width: 50,
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
          const Text('Surf Excel'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Text('Rs.70', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 10),
                  Text(
                    'Rs.75',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.grey,
                      decorationThickness: 2,
                    ),
                  ),
                ],
              ),
              Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: CustomColors.baseColor,
                ),
                child: const Center(
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: CustomColors.baseColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Item Total: Rs.120',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutPage()),
                );
              },
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
