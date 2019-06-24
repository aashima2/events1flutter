import 'package:flutter/material.dart';
class Demo1 extends StatefulWidget {
  @override
  _Demo1State createState() => _Demo1State();
}

class _Demo1State extends State<Demo1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('demo1',style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
