import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyShoppingApp());
}

class MyShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        initialRoute: '/',
        routes: {
          '/': (context) => VehicleListScreen(),
          '/cart': (context) => CartScreen(),
        },
      ),
    );
  }
}

class Vehicle {
  final String name;
  final String imageUrl;
  final double price;

  Vehicle({required this.name, required this.imageUrl, required this.price});
}

class Cart extends ChangeNotifier {
  final List<Vehicle> _items = [];

  List<Vehicle> get items => _items;

  void addToCart(Vehicle vehicle) {
    _items.add(vehicle);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

class VehicleListScreen extends StatelessWidget {
  final List<Vehicle> vehicles = [
    Vehicle(name: 'Car 1', imageUrl: 'assets/car1.jpeg', price: 50000),
    Vehicle(name: 'Car 2', imageUrl: 'assets/car1.jpeg', price: 60000),
    Vehicle(name: 'Bike 1', imageUrl: 'assets/car1.jpeg', price: 20000),
    Vehicle(name: 'Bike 2', imageUrl: 'assets/car1.jpeg', price: 25000),
    // Add more vehicles here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Shop'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              vehicles[index].imageUrl,
              width: 80,
            ),
            title: Text(vehicles[index].name),
            subtitle: Text('\$${vehicles[index].price.toString()}'),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                Provider.of<Cart>(context, listen: false)
                    .addToCart(vehicles[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cart.items[index].name),
            subtitle: Text('\$${cart.items[index].price.toString()}'),
            leading: Image.asset(
              cart.items[index].imageUrl,
              width: 80,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cart.clearCart();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Purchase Successful!'),
                content: Text('Thank you for your purchase.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: Text("Buy"),
      ),
    );
  }
}
