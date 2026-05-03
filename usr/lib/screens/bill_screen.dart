import 'package:flutter/material.dart';
import '../models/order.dart';

class BillScreen extends StatelessWidget {
  final AiOrder order;

  const BillScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Bill - ${order.id}'),
        backgroundColor: Colors.teal[800],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          width: 400,
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "SMARTBITE RESTAURANT",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
              const SizedBox(height: 8),
              const Text(
                "Tariq Road, Karachi\nPh: 021-111-222-333",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              const Text(
                "------------------------------------------------",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Order No:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(order.id),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Customer:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(order.customer.name),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Phone:", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(order.customer.phone),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "------------------------------------------------",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ...order.items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${item.quantity}x ${item.name}"),
                        Text("Rs. ${item.total.toStringAsFixed(0)}"),
                      ],
                    ),
                  )),
              const SizedBox(height: 16),
              const Text(
                "------------------------------------------------",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Subtotal:", style: TextStyle(color: Colors.grey)),
                  Text("Rs. ${order.subTotal.toStringAsFixed(0)}"),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("GST (16%):", style: TextStyle(color: Colors.grey)),
                  Text("Rs. ${order.tax.toStringAsFixed(0)}"),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Delivery:", style: TextStyle(color: Colors.grey)),
                  Text("Rs. ${order.deliveryFee.toStringAsFixed(0)}"),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("GRAND TOTAL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text("Rs. ${order.grandTotal.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Printing to Thermal Printer...')),
                  );
                },
                icon: const Icon(Icons.print),
                label: const Text("PRINT RECEIPT"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
