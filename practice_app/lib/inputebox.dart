// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.orange,
//           title: const Text('Flutter Container'),
//         ),
//         body: Center(
//             child: Container(
//                 width: 300,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextField(
//                         decoration: InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: const BorderSide(
//                                     color: Colors.deepOrange,
//                                     width: 2
//                                     )
//                                   ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide:  BorderSide(
//                                 color: Colors.blueAccent,
//                                 width: 2
//                               ))
//                                 )
//                               ),
//                     Container(height: 10,),
//                     TextField(
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: const BorderSide(
//                                     color: Colors.deepOrange, width: 11))))
//                   ],
//                 ))));
//   }
// }
