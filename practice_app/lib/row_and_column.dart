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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('R1', style: TextStyle(fontSize: 25)),
                  const Text('R2', style: TextStyle(fontSize: 25)),
                  const Text('R3', style: TextStyle(fontSize: 25)),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {}, 
                        child: const Text('Click1'),
                      ),
                      ElevatedButton(
                        onPressed: () {}, 
                        child: const Text('Click2'),
                      ),
                    ],
                  ),
                  const Text('R4', style: TextStyle(fontSize: 25)),
                  const Text('R5', style: TextStyle(fontSize: 25)),
                ],
              ),
              const Text('A', style: TextStyle(fontSize: 25)),
              const Text('B', style: TextStyle(fontSize: 25)),
              const Text('C', style: TextStyle(fontSize: 25)),
              const Text('D', style: TextStyle(fontSize: 25)),
              const Text('E', style: TextStyle(fontSize: 25)),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Click'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
