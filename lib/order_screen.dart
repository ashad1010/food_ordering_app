import 'package:flutter/material.dart';
import 'package:food_ordering_app/db_helper.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Map<String, dynamic>> foodItems = [];
  List<Map<String, dynamic>> selectedItems = [];
  String selectedDate = '';
  double targetCost = 0.0;
  String searchDate = '';
  List<Map<String, dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    DBHelper.instance.init().then((_) {
      fetchFoodItems();
    });
  }

  Future<void> fetchFoodItems() async {
    final items = await DBHelper.instance.getFoodItems();
    setState(() {
      foodItems = items;
    });
  }

  void saveOrder() async {
    if (selectedItems.isEmpty || selectedDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select items and date')),
      );
      return;
    }

    final itemNames = selectedItems.map((item) => item['name']).join(', ');
    await DBHelper.instance.insertOrder(selectedDate, itemNames);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order saved successfully!')),
    );

    setState(() {
      selectedItems = [];
      selectedDate = '';
    });
  }

  void searchOrders() async {
    if (searchDate.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a date to search')),
      );
      return;
    }

    final results = DBHelper.instance.getOrders(searchDate);
    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Ordering App'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Target Cost'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                targetCost = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Select Date'),
            onChanged: (value) {
              setState(() {
                selectedDate = value;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Search Date'),
            onChanged: (value) {
              setState(() {
                searchDate = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: searchOrders,
            child: const Text('Search Orders'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final item = foodItems[index];
                final isSelected = selectedItems.contains(item);

                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('Cost: \$${item['cost']}'),
                  trailing: isSelected
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
                  onTap: () {
                    if (isSelected) {
                      setState(() {
                        selectedItems.remove(item);
                      });
                    } else if (item['cost'] <= targetCost) {
                      setState(() {
                        selectedItems.add(item);
                        targetCost -= item['cost'];
                      });
                    }
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: saveOrder,
            child: const Text('Save Order'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final order = searchResults[index];
                return ListTile(
                  title: Text('Date: ${order['date']}'),
                  subtitle: Text('Items: ${order['items']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
