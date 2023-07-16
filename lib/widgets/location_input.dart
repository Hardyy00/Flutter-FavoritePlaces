// import 'package:flutter/material.dart';
// import "package:geolocator/geolocator.dart";

// class LocationInput extends StatefulWidget {
//   const LocationInput({super.key});

//   @override
//   State<LocationInput> createState() {
//     return _LocationInputState();
//   }
// }

// class _LocationInputState extends State<LocationInput> {
//   bool isGettingLocation = false;
//   Position? position;

//   void getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     Position currentPosition;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return;
//     }

//     setState(() {
//       isGettingLocation = true;
//     });
//     currentPosition = await Geolocator.getCurrentPosition();

//     setState(() {
//       isGettingLocation = false;
//     });

//     print(currentPosition.latitude);
//     print(currentPosition.longitude);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget preview = Text(
//       "No Location Chosen",
//       textAlign: TextAlign.center,
//       style: Theme.of(context)
//           .textTheme
//           .bodyLarge!
//           .copyWith(color: Theme.of(context).colorScheme.onBackground),
//     );

//     if (isGettingLocation) {
//       preview = const CircularProgressIndicator();
//     }

//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 170,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: 1,
//               color:
//                   Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
//             ),
//           ),
//           child: preview,
//         ),
//         const SizedBox(
//           height: 6,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextButton.icon(
//               onPressed: getCurrentLocation,
//               icon: const Icon(Icons.location_on),
//               label: const Text("Get Current Location"),
//             ),
//             TextButton.icon(
//               onPressed: () {},
//               icon: const Icon(Icons.map),
//               label: const Text("Get Location on map"),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
