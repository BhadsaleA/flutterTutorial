import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Rows and Columns practice",
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Rows and Columns practice"),),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blueGrey,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Start",style: TextStyle(fontSize: 20.0),),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: const Center(
                        child: Text("Red",style: TextStyle(fontSize: 15.0),),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            color: Colors.blue,
                            child: const Center(
                              child: Text("Blue",style: TextStyle(fontSize: 15.0),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text("Green",style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.pink,
                      child: const Center(
                        child: Text("Pink",style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.amber,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("End",style: TextStyle(fontSize: 20.0,),),
                  ],
                ),
              ),
            ),
          ],
          ),
        
      ),
    );
  }
}
