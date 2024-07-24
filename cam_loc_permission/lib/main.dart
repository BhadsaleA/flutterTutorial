import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Camera and Location Demo',
     home: HomePage(),
     debugShowCheckedModeBanner: false,

   );
 }
}
class HomePage extends StatelessWidget {
 final permissionCamera = Permission.camera;
 final permissionLocation = Permission.location;


 void locationPermissionStatus() async {
   // Request location permission
   final status = await permissionLocation.request();
   if (status == PermissionStatus.granted) {
     // Get the current location
     final position = await Geolocator.getCurrentPosition();
     print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
   } else {
     // Permission denied
     print('Location permission denied.');
   }
  }

 void cameraPermissionStatus() async {
  // Request camera permission
   final status = await permissionCamera.request();
   if (status.isGranted) {
     // Open the camera
     print('Opening camera...');
   } else {
     // Permission denied
     print('Camera permission denied.');
   }
  }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Camera and Location Demo'),
     ),
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           ElevatedButton(
             onPressed: cameraPermissionStatus,
             child: const Text('Open Camera'),
           ),
           ElevatedButton(
             onPressed: locationPermissionStatus,
             child: const Text('Get Location'),
           ),
         ],
       ),
     ),
   );
 }
}