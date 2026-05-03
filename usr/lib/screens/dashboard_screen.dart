import 'package:flutter/material.dart';
import '../models/order.dart';
import 'bill_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('SmartBite AI - Restaurant Portal', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal[800],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {
            setState(() {});
          }),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Row(
                children: [
                  Icon(Icons.mic, color: Colors.greenAccent, size: 18),
                  SizedBox(width: 4),
                  Text("AI Agent: Online", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )
        ],
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.white,
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.teal[50]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.restaurant, size: 40, color: Colors.teal[800]),
                      const SizedBox(height: 10),
                      Text('Tariq Road Tikka', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal[900])),
                      const Text('Karachi, PK', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                _buildSidebarItem(Icons.dashboard, "Live Dashboard", true),
                _buildSidebarItem(Icons.history, "Order History", false),
                _buildSidebarItem(Icons.menu_book, "Menu Management", false),
                _buildSidebarItem(Icons.analytics, "Revenue & AI Stats", false),
                _buildSidebarItem(Icons.settings, "Settings", false),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Live Orders (AI Handled)",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Watch as the AI Voice Agent talks to customers and drafts orders.",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: dummyOrders.length,
                      itemBuilder: (context, index) {
                        final order = dummyOrders[index];
                        return _buildOrderCard(order, context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, bool isActive) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.teal[800] : Colors.grey[600]),
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.teal[800] : Colors.grey[800],
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isActive ? Colors.teal[50] : null,
      onTap: () {},
    );
  }

  Widget _buildOrderCard(AiOrder order, BuildContext context) {
    bool isTakingOrder = order.status == 'AI Taking Order';
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      order.id,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isTakingOrder ? Colors.orange[100] : Colors.green[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          if (isTakingOrder) ...[
                            const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.orange),
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            order.status,
                            style: TextStyle(
                              color: isTakingOrder ? Colors.orange[800] : Colors.green[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  "${order.timestamp.hour}:${order.timestamp.minute.toString().padLeft(2, '0')}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Divider(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Customer Details", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.person, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(order.customer.name),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(order.customer.phone),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(child: Text(order.customer.address)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.auto_awesome, color: Colors.blue[800], size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                order.audioSummary,
                                style: TextStyle(color: Colors.blue[900], fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Order Items", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                      const SizedBox(height: 8),
                      if (order.items.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(child: Text("AI is drafting items...", style: TextStyle(color: Colors.grey))),
                        )
                      else ...[
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
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total Estimate", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              "Rs. ${order.grandTotal.toStringAsFixed(0)}",
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (!isTakingOrder)
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BillScreen(order: order),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.receipt_long),
                                label: const Text("Generate Bill"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal[800],
                                  foregroundColor: Colors.white,
                                ),
                              ),
                          ],
                        )
                      ]
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
