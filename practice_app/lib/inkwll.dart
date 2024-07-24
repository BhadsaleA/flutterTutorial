import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Page(),
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rows and Columns'),
      ),
      body: Center(
        child: InkWell(
            onTap: () {
              print('Tapped on container');
            },
            onLongPress: () {
              print('Long Pressed on container');
            },
            child: Container(
                width: 100,
                height: 100,
                color: Colors.amber,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      print('Tapped on link');
                    },
                    child: const Text(
                      "Click here",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
                    ),
                  ),
                ))),
      ),
    );
  }
}
