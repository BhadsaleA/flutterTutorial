// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera and Location Capture',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? imageFile;
  bool isLoading = false;
  loc.LocationData? locationData;
  List<Placemark>? placemark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Image & Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            imageFile == null
                ? Image.asset(
                    'assets/images/no_profile_image.png',
                    height: 300.0,
                    width: 300.0,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: Image.file(
                      imageFile!,
                      height: 300.0,
                      width: 300.0,
                      fit: BoxFit.fill,
                    ),
                  ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _handlePermissions();
              },
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Text(
                placemark != null
                    ? 'Address: ${placemark![0].name} ${placemark![0].street} ${placemark![0].subLocality} ${placemark![0].subAdministrativeArea} ${placemark![0].postalCode}'
                    : "Address: Not Available",
              ),
            ),
          ],
        ),
      ),
    );
  }

  final picker = ImagePicker();

  Future<void> _handlePermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
      Permission.location,
    ].request();

    if (statuses[Permission.storage]!.isGranted &&
        statuses[Permission.camera]!.isGranted &&
        statuses[Permission.location]!.isGranted) {
      _showImagePicker(context);
      _getLocation();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permissions not granted')),
      );
    }
  }

  Future<void> _getLocation() async {
    setState(() {
      isLoading = true;
    });

    try {
      print("try block");
      locationData = await loc.Location.instance.getLocation();
      if (locationData != null) {
        placemark = await placemarkFromCoordinates(
          locationData!.latitude!,
          locationData!.longitude!,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching location: $e')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Camera",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.pop(context);                      
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _imgFromCamera() async {
    try {
      final pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

      if (pickedFile != null) {
        imageCache.clear();
        setState(() {
          imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }
}
