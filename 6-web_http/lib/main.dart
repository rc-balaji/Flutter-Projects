import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Data Fetching',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _fetchedData = '';

  Future<void> _fetchData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _fetchedData = jsonData['title'];
      });
    } else {
      setState(() {
        _fetchedData = 'Failed to fetch data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP Data Fetching'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Fetched Data:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              _fetchedData,
              style: TextStyle(fontSize: 18),
            ),
            TextButton(onPressed: _fetchData, child: Text("fetch Data"))
          ],
        ),
      ),
    );
  }
}
