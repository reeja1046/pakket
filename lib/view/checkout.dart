import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pakket/const/color.dart';
import 'package:pakket/model/checkout.dart';
import 'package:pakket/view/order.dart';

class CheckoutPage extends StatefulWidget {
  final List<CheckoutItem> selectedItems;
  List<int> quantities;

  CheckoutPage({
    super.key,
    required this.selectedItems,
    required this.quantities,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedAddress = "default";

  int get itemTotal {
    int total = 0;
    for (int i = 0; i < widget.selectedItems.length; i++) {
      total += (widget.selectedItems[i].price * widget.quantities[i]).toInt();
    }
    return total;
  }

  int get deliveryCharge => 50;
  int get grandTotal => itemTotal + deliveryCharge;

  void _showChangeAddressModal() {
    TextEditingController addressController = TextEditingController();
    bool showAddressField = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with title and close icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Select An Address",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: CustomColors.baseColor,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Address Radio Tiles
                  RadioListTile(
                    value: "address1",
                    groupValue: _selectedAddress,
                    activeColor: Colors.orange,
                    onChanged: (val) {
                      setState(() => _selectedAddress = val.toString());
                      Navigator.pop(context);
                    },
                    title: const Text(
                      "John Doe, 123 Street, Kochi, Kerala - 682001",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  RadioListTile(
                    value: "address2",
                    groupValue: _selectedAddress,
                    activeColor: Colors.orange,
                    onChanged: (val) {
                      setState(() => _selectedAddress = val.toString());
                      Navigator.pop(context);
                    },
                    title: const Text(
                      "Jane Smith, 456 Road, Calicut, Kerala - 673001",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Add Address Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      setModalState(() {
                        showAddressField = true;
                      });
                    },
                    child: const Text("+ Add New Address"),
                  ),

                  if (showAddressField) ...[
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        hintText: "Enter your address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        if (addressController.text.trim().isNotEmpty) {
                          setState(() {
                            _selectedAddress = addressController.text.trim();
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Save Address"),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 245, 245),
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: const Color.fromARGB(255, 250, 245, 245),
      ),
      body: CustomScrollView(
        slivers: [
          // Item List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: widget.selectedItems.length,
              (context, index) {
                final item = widget.selectedItems[index];
                return Container(
                  margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(item.unit,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            const SizedBox(height: 4),
                            Text('Rs.${item.price.toInt()}/-',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 28, minHeight: 28),
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: () {
                                setState(() {
                                  if (widget.quantities[index] > 1) {
                                    widget.quantities[index]--;
                                  }
                                });
                              },
                            ),
                            Text('${widget.quantities[index]}',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 28, minHeight: 28),
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: () {
                                setState(() {
                                  widget.quantities[index]++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Before You Checkout Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Before you checkout",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 180,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.grey.shade200,
                                ),
                                child: const Icon(Icons.image),
                              ),
                              const SizedBox(height: 8),
                              const Center(
                                child: Text("Item Name",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Rs.99",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 30,
                                    width: 74,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: CustomColors.baseColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                                      onPressed: () {},
                                      child: const Text("Add",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12)),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Address and Price Details
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Price Details
                  const Text("Price Details",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  const Divider(height: 24),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Item total"),
                        Text("Rs. $itemTotal"),
                      ]),
                  SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Delivery charges"),
                        Text("Rs. $deliveryCharge"),
                      ]),
                  SizedBox(height: 5),
                  const Divider(height: 20),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Grand Total",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Rs. $grandTotal",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                  const SizedBox(height: 20),
                  const Divider(height: 20),
                  const SizedBox(height: 20),
                  // Address
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivering Address: ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: _showChangeAddressModal,
                        child: const Text("Change",
                            style: TextStyle(
                                color: CustomColors.baseColor,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  SizedBox(height: 35),
                  Text(
                    _selectedAddress == "default"
                        ? "John Doe, 123 Street, Kochi, Kerala - 682001"
                        : "+ Add new address",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  const Divider(height: 24),

                  // Payment Button

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Paying using\n",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: "Google Pay",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () {
                            // Place order logic
                            _showBlurDialog(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Rs. $grandTotal",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                width: 1,
                                height: 20,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Place Order",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBlurDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OrderScreen()),
          );
        });

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: CustomColors.baseColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: CustomColors.baseColor,
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 35),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Thank you! for\nplacing the order with\nUs!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Your order no. 23456, our delivery team will shortly contacting you.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
