import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text('ScrollBar'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 11),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                          margin: const EdgeInsets.only(right: 11),
                          height: 200,
                          width: 200,
                          color: Colors.lightGreen,
                          ),
                          
                          Container(
                          margin: const EdgeInsets.only(right: 11),
                          height: 200,
                          width: 200,
                          color: Colors.brown,
                          ),

                          Container(
                          margin: const EdgeInsets.only(right: 11),
                          height: 200,
                          width: 200,
                          color: Colors.pink,
                          ),

                          Container(
                          margin: const EdgeInsets.only(right: 11),
                          height: 200,
                          width: 200,
                          color: const Color.fromARGB(255, 243, 110, 70),
                          ),
                          Container(
                          margin: const EdgeInsets.only(right: 11),
                          height: 200,
                          width: 200,
                          color: Colors.lightGreen,
                          ),
                          
                          Container(
                          margin: const EdgeInsets.only(right: 11),
                          height: 200,
                          width: 200,
                          color: Colors.brown,
                          ),

                          Container(
                          margin: const EdgeInsets.only(right: 11),
                          height: 200,
                          width: 200,
                          color: Colors.pink,
                          ),

                          Container(
                          margin: const EdgeInsets.only(right: 11),
                          height: 200,
                          width: 200,
                          color: const Color.fromARGB(255, 243, 110, 70),
                          ),
                        ]
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 11),
                  height: 200,
                  color: Colors.lightBlue,
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 11),
                  height: 200,
                  color: const Color.fromARGB(255, 248, 201, 59),
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 11),
                  height: 200,
                  color: const Color.fromARGB(255, 231, 151, 30),
                ),
                
                Container(
                  margin: const EdgeInsets.only(bottom: 11),
                  height: 200,
                  color: const Color.fromARGB(255, 195, 74, 175),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 11),
                  height: 200,
                  color: const Color.fromARGB(255, 195, 102, 74),
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 11),
                  height: 200,
                  color: const Color.fromARGB(255, 197, 51, 75),
                ),
                
                Container(
                  margin: const EdgeInsets.only(bottom: 11),
                  height: 200,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        )
      );
  }
}
