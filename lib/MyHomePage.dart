

import 'package:flutter/material.dart';
import 'package:routing/components/CalculatorButton.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String screenText = "0";
  String screenDone = "0";
  String operation = "";

    
  pressNumber(int number){
    setState(() {
       if(screenText == "0"){
         screenText = '$number';
       }else{
         screenText = '$screenText$number';
       }
    });
  }

  pressOperation(String oprtion){
    if(operation == "" ){
      screenDone = screenText;
      screenText = "0";
    }else{
      setState(() {
        double inputPrev = double.parse(screenDone);
        double inputCurr = double.parse(screenText);
        double result = 0;

        if(operation == "/"){
            result = inputPrev / inputCurr;  
        }
        if(operation == "X"){
            result = inputPrev * inputCurr;  
        }
        if(operation == "+"){
            result = inputPrev + inputCurr;  
        }
        if(operation == "-"){
            result = inputPrev - inputCurr;  
        }

        screenText = '$result';
        screenDone = "0";
        operation = "";
      });
    }
    
    operation = oprtion;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  screenText,
                  style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          GridView.count(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            crossAxisCount: 4,
            children: <Widget>[
              CalculatorButton(
                backgroundColor: Theme.of(context).primaryColorLight, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: 'C',
                onTap: (){
                  setState(() {
                    screenText = "0";
                    screenDone = "0";
                    operation = "";
                  });
                },
              ),
              CalculatorButton(
                backgroundColor: Theme.of(context).primaryColorLight, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '+/-',
                onTap: (){
                  setState(() {
                    if(!screenText.contains('-') && screenText != '0'){
                      screenText = '-$screenText';
                    }else{
                      screenText = screenText.replaceAll('-', '');
                    }
                  });
                },
              ),
              CalculatorButton(
                backgroundColor: Theme.of(context).primaryColorLight, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '%',
                onTap: (){
                  setState(() {
                    double screenDouble = double.parse(screenText);
                    screenDouble /= 100;
                    screenText = '$screenDouble';
                  });
                },
              ),
              CalculatorButton.Icon(
                backgroundColor: Theme.of(context).primaryColorDark, 
                foregroundColor: Theme.of(context).primaryColorLight, 
                text: "Backspace", 
                icon: Icons.backspace, 
                onTap: (){
                   setState(() {
                    if (screenText == '0' ||
                        screenText == '' ||
                        screenText.length == 1) {
                      screenText = '0';
                    } else {
                      screenText =
                          screenText.substring(0, screenText.length - 1);
                    }
                  });
                }
              ),
              CalculatorButton(
                backgroundColor: Colors.white, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '7',
                onTap: (){
                  pressNumber(7);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '8',
                 onTap: (){
                  pressNumber(8);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '9',
                 onTap: (){
                  pressNumber(9);
                },
              ),
              CalculatorButton(
                foregroundColor: Theme.of(context).primaryColorLight, 
                backgroundColor: Theme.of(context).primaryColorDark, 
                text: '/',
                onTap: (){
                  pressOperation('/');
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '4',
                 onTap: (){
                  pressNumber(4);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '5',
                 onTap: (){
                  pressNumber(5);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '6',
                 onTap: (){
                  pressNumber(6);
                },
              ),
              CalculatorButton(
                foregroundColor: Theme.of(context).primaryColorLight, 
                backgroundColor: Theme.of(context).primaryColorDark, 
                text: 'X',
                onTap: (){
                  pressOperation('X');
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '1',
                 onTap: (){
                  pressNumber(1);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '2',
                 onTap: (){
                  pressNumber(2);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '3',
                 onTap: (){
                  pressNumber(3);
                },
              ),
              CalculatorButton(
                foregroundColor: Theme.of(context).primaryColorLight, 
                backgroundColor: Theme.of(context).primaryColorDark, 
                text: '-',
                onTap: (){
                  pressOperation('-');
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '0',
                 onTap: (){
                  pressNumber(0);
                },
              ),
              CalculatorButton(
                backgroundColor: Colors.white, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '.',
                onTap: (){
                  setState(() {
                    if(!screenText.contains('.')){
                      screenText = '$screenText.';
                    }
                  });
                },
              ),
              CalculatorButton(
                backgroundColor: Theme.of(context).primaryColorLight, 
                foregroundColor: Theme.of(context).primaryColorDark, 
                text: '=',
                onTap: (){
                  setState(() {
                    if(operation != "" && screenText != "0" && screenDone != "0"){
                      double inputPrev = double.parse(screenDone);
                      double inputCurr = double.parse(screenText);
                      double result = 0;

                      if(operation == "/"){
                          result = inputPrev / inputCurr;  
                      }
                      if(operation == "X"){
                          result = inputPrev * inputCurr;  
                      }
                      if(operation == "+"){
                          result = inputPrev + inputCurr;  
                      }
                      if(operation == "-"){
                          result = inputPrev - inputCurr;  
                      }

                      screenText = '$result';
                      screenDone = "0";
                      operation = "";
                    }
                  });
                },
              ),
              CalculatorButton(
                foregroundColor: Theme.of(context).primaryColorLight, 
                backgroundColor: Theme.of(context).primaryColorDark, 
                text: '+',
                onTap: (){
                 pressOperation('+');
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}