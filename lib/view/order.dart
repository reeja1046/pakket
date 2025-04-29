import 'package:flutter/material.dart';
import 'package:pakket/const/color.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  void _showOrderDetails(BuildContext context, String orderNumber) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: CustomColors.baseColor,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12),
                Text('Order No: $orderNumber',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  '2025-04-25 12:30 PM',
                  style: TextStyle(color: CustomColors.baseColor),
                ),
                SizedBox(height: 8),
                Text('Delivered at:'),
                Text('123, Flutter Street, Kochi, Kerala'),
                Divider(height: 30),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product: Pakket T-Shirt'),
                      SizedBox(height: 8),
                      Text('Qty: 1'),
                      SizedBox(height: 8),
                      Text('Price: ₹499'),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _priceRow('Item total', '₹499'),
                      _priceRow('Delivery charge', '₹50'),
                      Divider(),
                      _priceRow('Total', '₹549', isBold: true),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _priceRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isBold ? TextStyle(fontWeight: FontWeight.bold) : null),
          Text(value,
              style: isBold ? TextStyle(fontWeight: FontWeight.bold) : null),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = [
      {'orderNumber': '#1001', 'status': 'Delivered'},
      {'orderNumber': '#1002', 'status': 'Shipped'},
      {'orderNumber': '#1003', 'status': 'Processing'},
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text('Your Orders', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                height: 40,
                width: double.infinity,
                color: CustomColors.baseColor,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('Your orders list',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              ...orders.map((order) => Column(
                    children: [
                      ListTile(
                        title: Text('Order Number: ${order['orderNumber']}'),
                        subtitle: Text(
                          'Status: ${order['status']}',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: TextButton(
                          onPressed: () =>
                              _showOrderDetails(context, order['orderNumber']!),
                          child: Text(
                            'View in details',
                            style: TextStyle(color: CustomColors.baseColor),
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
