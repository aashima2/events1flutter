import 'package:flutter/material.dart';

class demo extends StatefulWidget {
  @override
  _demoState createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        title: Text('demo',style: TextStyle(color: Colors.black),),
    ),
    backgroundColor: Colors.red,
    body: Text(
    'Welcome to BMI Calculator',
    style: new TextStyle(
    fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.bold),
    )
    );
  }
}
