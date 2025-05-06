Food Ordering App (Flutter)
A simple yet functional Flutter-based food ordering app developed using Dart and Hive for local storage. Created to practice and demonstrate database integration, user input handling, and Flutter UI principles.

Note: Project uses Hive instead of sqflite to support web & desktop compatibility.

Features
•	Input target price and date to begin an order
•	Choose from a list of 20 food items, each with preset prices
•	Order only succeeds if total cost stays within the limit
•	Save and retrieve orders by date using a search function
•	Data stored locally using the Hive database (compatible with Flutter Web)

Tech Stack
•	Flutter
•	Dart
•	Hive (local NoSQL database)
•	VS Code (used instead of Android Studio for efficiency)

Project Structure (Key Files)
/lib
  |── main.dart              # Entry point
  |── home_page.dart         # Core UI for inputs, selections, and results
  |── order_model.dart       # Hive database model
  |── db_functions.dart      # Logic for saving and retrieving orders
/assets
  └── food_items.json        # Sample list of 20 menu items

Setup Instructions
1.	Clone the repo:
  git clone https://github.com/your-username/food-ordering-app.git
  cd food-ordering-app
2.	Install dependencies:
  flutter pub get
3.	Run the app (desktop/web):
  flutter run -d windows   # Or chrome, depending on your target

Lessons Learned
•	Mastered Dart fundamentals and Flutter UI design
•	Implemented persistent storage via Hive
•	Resolved environment issues by switching from Android Studio to VS Code
•	Overcame web incompatibility with traditional mobile DB packages by adapting tech stack

License
No commercial license applied.

Author
Ashad Ahmed
GitHub: https://github.com/ashad1010
