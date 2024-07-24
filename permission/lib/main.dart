import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission/camera.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera and location capture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Camera and location capture'),
      debugShowCheckedModeBanner: false,
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
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    // Request multile permission at once
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.location,
    ].request();

    statuses.forEach((permission, status) {
      if (status.isDenied) {
        openAppSettings();
      }
    });
  }
  // Check each permission status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final cameras = await availableCameras();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => cameraOpen(cameras: cameras),));
              },
              child: const Text('Capture1'),
            ),
            Container(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Capture2'),
            )
          ],
        ),
      ),
    );
  }
}
