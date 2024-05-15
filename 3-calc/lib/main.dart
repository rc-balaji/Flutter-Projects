import 'package:flutter/material.dart';
import 'package:dart_eval/dart_eval.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";

  void _onPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
      } else if (buttonText == "=") {
        _output = _calculateOutput();
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
    });
  }

  String _calculateOutput() {
    // Basic calculation logic goes here
    // This is a simplified example
    try {
      return eval(_output).toString();
    } catch (e) {
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 20.0),
            buildRow(["7", "8", "9", "/"]),
            SizedBox(height: 10.0),
            buildRow(["4", "5", "6", "x"]),
            SizedBox(height: 10.0),
            buildRow(["1", "2", "3", "-"]),
            SizedBox(height: 10.0),
            buildRow(["C", "0", "=", "+"]),
          ],
        ),
      ),
    );
  }

  Widget buildRow(List<String> buttons) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons
            .map(
              (buttonText) => ElevatedButton(
                onPressed: () => _onPressed(buttonText),
                child: Text(
                  buttonText,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
