import 'package:hive/hive.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  late Box foodItemsBox;
  late Box ordersBox;

  DBHelper._init();

  Future<void> init() async {
    foodItemsBox = await Hive.openBox('food_items');
    ordersBox = await Hive.openBox('orders');

    // Prepopulate with specific food items if the box is empty
    if (foodItemsBox.isEmpty) {
      final foodNames = [
        'Pizza',
        'Burger',
        'Pasta',
        'Salad',
        'Sushi',
        'Tacos',
        'Sandwich',
        'Steak',
        'Soup',
        'Fries',
        'Ice Cream',
        'Cake',
        'Curry',
        'Noodles',
        'Dumplings',
        'Ramen',
        'Burrito',
        'Falafel',
        'Paella',
        'Quiche'
      ];

      for (int i = 0; i < foodNames.length; i++) {
        foodItemsBox.add({'name': foodNames[i], 'cost': (i + 1) * 10.0});
      }
    }
  }

  List<Map<String, dynamic>> getFoodItems() {
    return foodItemsBox.values.cast<Map<String, dynamic>>().toList();
  }

  Future<void> insertOrder(String date, String items) async {
    await ordersBox.add({'date': date, 'items': items});
  }

  List<Map<String, dynamic>> getOrders(String date) {
    return ordersBox.values
        .cast<Map<String, dynamic>>()
        .where((order) => order['date'] == date)
        .toList();
  }
}
