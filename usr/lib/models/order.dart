class OrderItem {
  final String name;
  final int quantity;
  final double price;

  OrderItem({required this.name, required this.quantity, required this.price});

  double get total => price * quantity;
}

class CustomerInfo {
  final String phone;
  final String address;
  final String name;

  CustomerInfo({required this.phone, required this.address, this.name = "Unknown"});
}

class AiOrder {
  final String id;
  final DateTime timestamp;
  final CustomerInfo customer;
  final List<OrderItem> items;
  String status; // 'AI Taking Order', 'Confirmed', 'Preparing', 'Delivered'
  final String audioSummary; // Example: "Customer wants extra spicy"

  AiOrder({
    required this.id,
    required this.timestamp,
    required this.customer,
    required this.items,
    this.status = 'Confirmed',
    this.audioSummary = '',
  });

  double get subTotal => items.fold(0, (sum, item) => sum + item.total);
  double get tax => subTotal * 0.16; // 16% GST in Pakistan
  double get deliveryFee => 150.0;
  double get grandTotal => subTotal + tax + deliveryFee;
}

// Dummy Data for the MVP
List<AiOrder> dummyOrders = [
  AiOrder(
    id: "ORD-1029",
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    customer: CustomerInfo(phone: "0300-1234567", address: "House 12, Street 4, DHA Phase 5, Lahore", name: "Ali Khan"),
    status: 'Confirmed',
    audioSummary: "AI Agent: Order confirmed. Customer requested raita and extra salad.",
    items: [
      OrderItem(name: "Chicken Karahi (Half)", quantity: 1, price: 1200),
      OrderItem(name: "Garlic Naan", quantity: 3, price: 100),
      OrderItem(name: "Mint Margrita", quantity: 2, price: 350),
    ],
  ),
  AiOrder(
    id: "ORD-1030",
    timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    customer: CustomerInfo(phone: "0333-9876543", address: "F-8 Markaz, Islamabad", name: "Sara"),
    status: 'AI Taking Order',
    audioSummary: "Live Call: Customer is asking about deals...",
    items: [],
  ),
  AiOrder(
    id: "ORD-1028",
    timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
    customer: CustomerInfo(phone: "0321-5556667", address: "Gulshan-e-Iqbal, Karachi", name: "Ahmed"),
    status: 'Preparing',
    audioSummary: "AI Agent: Address verified. Standard spice level.",
    items: [
      OrderItem(name: "Zinger Burger Deal", quantity: 2, price: 850),
      OrderItem(name: "Fries (Large)", quantity: 1, price: 300),
    ],
  ),
];
