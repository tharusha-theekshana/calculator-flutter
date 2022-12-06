import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 30.0;
  double resultFontSize = 50.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 30.0;
        resultFontSize = 50.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 30.0;
        resultFontSize = 50.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 30.0;
        resultFontSize = 50.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1* buttonHeight,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: buttonColor,
              shape: CircleBorder(),
              ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Calculator'),
      backgroundColor: Colors.red),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 50, 15, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize , color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 15, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize , color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButton("C", 1, Colors.grey),
                buildButton("⌫", 1, Colors.grey),
                buildButton("÷", 1, Colors.grey),
                buildButton("×", 1, Color.fromARGB(255, 11, 28, 128))
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButton("7", 1, Colors.grey),
                buildButton("8", 1, Colors.grey),
                buildButton("9", 1, Colors.grey),
                buildButton("-", 1, Color.fromARGB(255, 11, 28, 128))
              ],
            ),
          ),
         
          Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButton("4", 1, Colors.grey),
                buildButton("5", 1, Color.fromARGB(255, 129, 126, 126)),
                buildButton("6", 1, Colors.grey),
                buildButton("+", 1, Color.fromARGB(255, 11, 28, 128))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildButton("1", 1, Colors.grey),
                buildButton("2", 1, Colors.grey),
                buildButton("3", 1, Colors.grey),
                buildButton(".", 1, Color.fromARGB(255, 11, 28, 128))
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: StadiumBorder(),
                        padding: EdgeInsets.fromLTRB(60, 18, 60, 18)),
                    onPressed: () => buttonPressed("00"),
                    child: Text(
                      "00",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                buildButton("0", 1, Colors.grey),
                buildButton("=", 1, Colors.red),
              ],
            ),
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
