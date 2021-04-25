import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double fontSizeEquation = 38;
  double fontSizeResult = 48;

  buttonPressed(String label) {
    setState(() {
      if (label == "C") {
        fontSizeEquation = 48;
        fontSizeResult = 38;
        equation = "0";
        result = "0";
      } else if (label == "⌫") {
        fontSizeEquation = 48;
        fontSizeResult = 38;
        equation = equation.substring(0, equation.length - 1);
      } else if (label == "%") {
        fontSizeEquation = 38;
        fontSizeResult = 48;
        result = ((double.parse(equation)) * 0.01).toString();
      } else if (label == "=") {
        fontSizeEquation = 38;
        fontSizeResult = 48;

        expression = equation;
        expression = expression.replaceAll("x", "*");
        expression = expression.replaceAll("÷", "/");
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          result = '${exp.evaluate(EvaluationType.REAL, ContextModel())}';
        } catch (E) {
          print("ERROR");
        }
      } else {
        if (equation == "0") {
          equation = label;
        } else {
          equation = equation + label;
        }
      }
    });
  }

  Widget button(String label, Color color) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 50,
      child: MaterialButton(
          color: Colors.white,
          shape: CircleBorder(),
          onPressed: () => buttonPressed(label),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.normal,
              color: color,
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff283637),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Calculator"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      equation,
                      style: TextStyle(
                        fontSize: fontSizeEquation,
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      result,
                      style: TextStyle(
                        fontSize: fontSizeResult,
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                height: MediaQuery.of(context).size.height * 0.5,
                //width: MediaQuery.of(context).size.width,
                color: Color(0xff283637),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        button("C", Color(0xff009788)),
                        button("⌫", Color(0xff009788)),
                        button("%", Color(0xff009788)),
                        button("÷", Color(0xff009788)),
                      ],
                    ),
                    Row(
                      children: [
                        button("7", Colors.black38),
                        button("8", Colors.black38),
                        button("9", Colors.black38),
                        button("x", Color(0xff009788)),
                      ],
                    ),
                    Row(
                      children: [
                        button("4", Colors.black38),
                        button("5", Colors.black38),
                        button("6", Colors.black38),
                        button("_", Color(0xff009788)),
                      ],
                    ),
                    Row(
                      children: [
                        button("1", Colors.black38),
                        button("2", Colors.black38),
                        button("3", Colors.black38),
                        button("+", Color(0xff009788)),
                      ],
                    ),
                    Row(
                      children: [
                        button("00", Colors.black38),
                        button("0", Colors.black38),
                        button(".", Colors.black38),
                        button("=", Color(0xff009788)),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
