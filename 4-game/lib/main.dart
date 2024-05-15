import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyGameApp());
}

class MyGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gaming App',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _targetNumber = 0;
  int _stepsLeft = 10;
  bool _isGameOver = false;
  String _feedbackMessage = '';
  TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generateTargetNumber();
  }

  void _generateTargetNumber() {
    _targetNumber =
        Random().nextInt(100) + 1; // Generate a random number between 1 and 100
  }

  void _checkNumber(int number) {
    setState(() {
      _stepsLeft--;
      if (number == _targetNumber) {
        _isGameOver = true;
        _showResultDialog(true);
      } else if (_stepsLeft == 0) {
        _isGameOver = true;
        _showResultDialog(false);
      } else {
        _giveFeedback(number);
      }
    });
  }

  void _giveFeedback(int number) {
    if (number < _targetNumber) {
      _feedbackMessage = 'Too low!';
    } else {
      _feedbackMessage = 'Too high!';
    }
  }

  void _showResultDialog(bool isWinner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isWinner ? 'Congratulations!' : 'Game Over'),
          content: isWinner
              ? Text('You found the number!')
              : Text('You ran out of steps. The number was $_targetNumber.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (!isWinner) {
                  _resetGame();
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _resetGame() {
    setState(() {
      _stepsLeft = 5;
      _generateTargetNumber();
      _isGameOver = false;
      _feedbackMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find the Number'),
      ),
      body: Center(
        child: _isGameOver
            ? Text(
                'Game Over',
                style: TextStyle(fontSize: 24.0),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Steps Left: $_stepsLeft',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    _feedbackMessage,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Enter a number between 1 and 100:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    width: 100.0,
                    child: TextField(
                      controller: _inputController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Enter',
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: _stepsLeft > 0
                        ? () {
                            int? inputNumber =
                                int.tryParse(_inputController.text);
                            if (inputNumber != null) {
                              _checkNumber(inputNumber);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter a valid number.'),
                                ),
                              );
                            }
                          }
                        : null,
                    child: Text('Check'),
                  ),
                ],
              ),
      ),
    );
  }
}
