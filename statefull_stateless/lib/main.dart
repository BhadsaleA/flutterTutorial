import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddressToCoordinates(),
    );
  }
}

class AddressToCoordinates extends StatefulWidget {
  @override
  _AddressToCoordinatesState createState() => _AddressToCoordinatesState();
}

class _AddressToCoordinatesState extends State<AddressToCoordinates> {
  final TextEditingController _controller = TextEditingController();

  double? latitude;
  double? longitude;
  File? imageFile;
  bool isLoading = false;
  loc.LocationData? locationData;
  List<Placemark>? placemark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address to Coordinates'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Address',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convertAddressToCoordinates,
              child: const Text('Get Coordinates'),
            ),
            const SizedBox(height: 16.0),
            if (latitude != null && longitude != null)
              Text('Latitude: $latitude, Longitude: $longitude'),
            if (latitude == null || longitude == null)
              const Text('No coordinates available'),
            const SizedBox(height: 16.0),
            imageFile == null
                ? Image.asset(
                    'assets/images/no_profile_image.png',
                    height: 200.0,
                    width: 200.0,
                  )
                : Container(
                    alignment: Alignment.center,
                    constraints: const BoxConstraints(
                      maxWidth: 200,
                      maxHeight: 200,
                    ),
                    child: Image.file(
                      imageFile!,
                      height: 200.0,
                      width: 200.0,
                      fit: BoxFit.fill,
                    ),
                  ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  _handlePermissions();
                },
                child: const Text('Upload Image')),
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

  void _convertAddressToCoordinates() async {
    String address = _controller.text;
    try {
      List<Location> locations = await locationFromAddress(address);
      setState(() {
        latitude = locations.first.latitude;
        longitude = locations.first.longitude;
      });
    } catch (e) {
      print(e);
      setState(() {
        latitude = null;
        longitude = null;
      });
    }
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
      _checkLocation();
    } else if (statuses[Permission.storage]!.isDenied &&
        statuses[Permission.camera]!.isDenied &&
        statuses[Permission.location]!.isDenied) {
      openAppSettings();
      _checkLocation();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permissions not granted')),
      );
    }
  }

  bool areCoordinatesSame(double lat1, double lon1, double lat2, double lon2,
      {double tolerance = 0.00009}) {
    return (lat1 - lat2).abs() < tolerance && (lon1 - lon2).abs() < tolerance;
  }

  void _checkLocation() async {
    try {
      print("In try block....");

      locationData = await loc.Location.instance.getLocation();

      print(locationData!.latitude);
      print(locationData!.longitude);

      if (locationData != null && latitude != null && longitude != null) {
        placemark = await placemarkFromCoordinates(
          locationData!.latitude!,
          locationData!.longitude!,
        );
        bool isSame = areCoordinatesSame(locationData!.latitude!,
            locationData!.longitude!, latitude!, longitude!,
            tolerance: 0.0009);
        if (isSame) {
          _showImagePicker(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Location coordinates are not the same')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching location: $e')),
      );
    }
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
                          SizedBox(
                            height: 12.0,
                          ),
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
                  ))
                ],
              ),
            ),
          );
        });
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
