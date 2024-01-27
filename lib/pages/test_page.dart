import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  static const addSign = "\u002B";
  static const subtractSign = "\u2212";
  static const multiplySign = "\u00D7";
  static const divideSign = "\u00F7";
  static const equalSign = "\u003D";

  String displayValue = "0"; // Initial display value

  void handleButtonPress(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        // Clear the display and reset to 0
        displayValue = "0";
      } else if (buttonText == "⌫") {
        // Remove the last character from the display
        displayValue = displayValue.length > 1
            ? displayValue.substring(0, displayValue.length - 1)
            : "0";
      } else if (buttonText == equalSign) {
        // Reset the display to 0 (no actual calculation is performed)
        displayValue = "0";
      } else if (buttonText == addSign ||
          buttonText == subtractSign ||
          buttonText == multiplySign ||
          buttonText == divideSign) {
        // Condition 1: If the display is '0', do nothing
        if (displayValue != "0") {
          // Condition 2: If the rightmost character is a number, append the operator
          if (RegExp(r'[0-9]').hasMatch(displayValue[displayValue.length - 1])) {
            displayValue += buttonText;
          }
          // Condition 3: If the rightmost character is an operator, replace it with the new operator
          else if (RegExp(r'[+\-*/]').hasMatch(displayValue[displayValue.length - 1])) {
            displayValue = displayValue.substring(0, displayValue.length - 1) + buttonText;
          }
        }
      } else {
        // Handle other buttons (numbers)
        if (displayValue == "0") {
          displayValue = buttonText;
        } else {
          displayValue += buttonText;
        }
      }
    });
  }

  String evaluateExpression(String expression) {
    try {
      // Replace Unicode characters with their corresponding operators
      expression = expression.replaceAll("×", "*").replaceAll("÷", "/");

      // Using 'dart:math' to perform basic arithmetic operations
      double result = double.parse(expression);
      return result.toString();
    } catch (e) {
      return "Error";
    }
  }

  Widget buildCal({
    required dynamic label,
    Color color = Colors.black,
    double width = 50.0,
    double height = 70.0,
  }) {
    String text = '';

    if (label is IconData) {
      text = label.codePoint.toString();
    } else if (label is String) {
      text = label;
    }

    Color textColor = color; // Set the text color
    Color backgroundColor =
        Colors.transparent; // Set the default background color

    if (label == addSign ||
        label == subtractSign ||
        label == multiplySign ||
        label == divideSign) {
      // Set the background color to blue for add, subtract, multiply, and divide buttons
      backgroundColor = Colors.blue;
      textColor = Colors.white; // Set text color to white for better visibility
    }
    if (label == equalSign) {
      // Set the background color to blue for add, subtract, multiply, and divide buttons
      backgroundColor = Colors.lightGreen;
      textColor = Colors.white; // Set text color to white for better visibility
    }
    if (label == '4'|| label == '1'|| label == '2'|| label == '3'|| label == '5'||label == '6'||label == '7'||label == '8'||label == '9'||label == '0') {
      // Set the background color to blue for add, subtract, multiply, and divide buttons
      backgroundColor = Colors.deepOrangeAccent;
      textColor = Colors.white; // Set text color to white for better visibility
    }

    return Expanded(
      child: Container(
        width: 90.0,
        height: 85.0,
        decoration: BoxDecoration(
          color: backgroundColor, // Set background color
          border: Border.all(color: Colors.grey),
        ),
        child: TextButton(
          onPressed: () {
            // Handle button press here
            handleButtonPress(label);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (label is IconData) Icon(label, color: textColor),
              if (label is String)
                Text(
                  label,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20.0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Display at the top with some padding
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              displayValue,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 32.0,
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.blue,
                  ),
                  child: buildCal(
                    label: 'C',
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Colors.blue,
                  ),
                  child: buildCal(
                    label: '⌫',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              buildCal(label: '7'),
              SizedBox(width: 7),
              buildCal(label: '8'),
              SizedBox(width: 7),
              buildCal(label: '9'),
              SizedBox(width: 7),
              buildCal(label: divideSign, color: Colors.black),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              buildCal(label: '4'),
              SizedBox(width: 7),
              buildCal(label: '5'),
              SizedBox(width: 7),
              buildCal(label: '6'),
              SizedBox(width: 7),
              buildCal(label: multiplySign),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              buildCal(label: '1'),
              SizedBox(width: 7),
              buildCal(label: '2'),
              SizedBox(width: 7),
              buildCal(label: '3'),
              SizedBox(width: 7),
              buildCal(label: subtractSign),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(7.0),
                  child: buildCal(label: '0', width: 100.0, height: 70.0),
                ),
              ),
              SizedBox(width: 7),
              buildCal(label: addSign),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              buildCal(label: equalSign),
            ],
          ),
          // Add more rows or customize as needed
          // ...
        ],
      ),
    );
  }
}
