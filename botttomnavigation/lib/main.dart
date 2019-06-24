import 'package:flutter/material.dart';
import 'demo.dart';
import 'Demo1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int curIndex = 0;
  demo p1 = new demo();
  Demo1 p2 = new Demo1();
  List<Widget> Pages;
  Widget currentPage;

  void _incrementCounter() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Pages = [p1, p2];
    currentPage = p1;
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Demo1(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
//          backgroundColor: Colors.red,
          body: currentPage,
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: curIndex,
              onTap: (index) {
                setState(() {
                  curIndex = index;
                  currentPage = Pages[index];
                });
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(
                    Icons.home,
                    color: curIndex == 0 ? Colors.blueGrey : Colors.grey,
                  ),
                  title: Text('Home',
                      style: TextStyle(
                          color:
                              curIndex == 0 ? Colors.blueGrey : Colors.grey)),
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(Icons.event,
                      color: curIndex == 1 ? Colors.blueGrey : Colors.grey),
                  title: Text(
                    'Events',
                    style: TextStyle(
                        color: curIndex == 1 ? Colors.blueGrey : Colors.grey),
                  ),
                ),

              ]),
        ));
  }
}
