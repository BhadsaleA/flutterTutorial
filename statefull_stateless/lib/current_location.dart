import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 247, 162, 4)),
        useMaterial3: true,
      ),
      home: const HomeScreen(title: 'Location'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  loc.LocationData? locationData;
  List<Placemark>? placemark;

  final TextStyle textStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  void getPermission() async {
    if (await Permission.location.isGranted) {
      // get location
      getlocation();
    } else {
      Permission.location.request();
    }
  }

  void getlocation() async {
    setState(() {
      isLoading = true;
    });
    locationData = await loc.Location.instance.getLocation();

    setState(() {
      isLoading = false;
    });
  }

  void getAddress() async {
    if (locationData != null) {
      setState(() {
        isLoading = true;
      });
      
      placemark = await placemarkFromCoordinates(
          locationData!.latitude!, locationData!.longitude!);
      
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      locationData != null
                          ? 'Latitiude: ${locationData!.latitude}'
                          : 'Latitude: No Available',
                      style: textStyle,
                    ),
                    Text(
                      locationData != null
                          ? 'Longitude: ${locationData!.longitude}'
                          : 'Longitude: No Available',
                      style: textStyle,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: getPermission,
                      child: const Text('Get Location'),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Text(
                        placemark != null? 'Address: ${placemark![0].name} ${placemark![0].street} ${placemark![0].subLocality} ${placemark![0].subAdministrativeArea} ${placemark![0].postalCode}'
                        : "Address: Not Available",
                      style: textStyle,
                    ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: getAddress,
                      child: const Text('Get Address'),
                    ),
                  ],
                ),
              ));
  }
}
