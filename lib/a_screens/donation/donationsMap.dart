
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:klam/generalLayout/generalLayoutCtr.dart';

import '../../mapPicker/mapVoids.dart';
import '../../styles.dart';

class DonationsMap extends StatefulWidget {
  const DonationsMap({super.key});

  @override
  State<DonationsMap> createState() => _DonationsMapState();
}

class _DonationsMapState extends State<DonationsMap> {
// Define the boundaries of the Monastir region
  LatLng monastirBoundsNorthEast = LatLng(35.8133, 10.8926); // Northeast corner
  LatLng monastirBoundsSouthWest = LatLng(35.7117, 10.6506); // Southwest corner
  GoogleMapController? mapContr;

// Create a function to generate random coordinates within Monastir's bounds
  LatLng generateRandomLatLngInMonastir() {
    // Create a random instance
    Random random = Random();

    // Calculate a random latitude within the boundaries
    double randomLat = monastirBoundsSouthWest.latitude +
        random.nextDouble() * (monastirBoundsNorthEast.latitude - monastirBoundsSouthWest.latitude);

    // Calculate a random longitude within the boundaries
    double randomLng = monastirBoundsSouthWest.longitude +
        random.nextDouble() * (monastirBoundsNorthEast.longitude - monastirBoundsSouthWest.longitude);

    // Return the random LatLng within the Monastir region
    return LatLng(randomLat, randomLng);
  }

// Create random markers
  Set<Marker> generateRandomMarkersInMonastir(int numMarkers) {
    Set<Marker> markers = {};

    // Generate the specified number of random markers
    for (int i = 0; i < numMarkers; i++) {
      // Generate a random LatLng within Monastir
      LatLng randomLatLng = generateRandomLatLngInMonastir();

      // Create a new marker
      Marker marker = Marker(
        markerId: MarkerId('marker_$i'),
        position: randomLatLng,
        infoWindow: InfoWindow(title: 'Marker $i'),
      );

      // Add the marker to the set
      markers.add(marker);
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgCol,
      child: GetBuilder<LayoutCtr>(
          initState: (_){
            //reqCtr.addMarkers();
          },
          builder: (_) {
            return GoogleMap(
              markers: generateRandomMarkersInMonastir(10), // Specify the number of random markers
              initialCameraPosition: CameraPosition(
                target: susahLoc, // Set the initial camera position to a location of your choice
                zoom: 12,
              ),
              onMapCreated: (GoogleMapController controller) {
                mapContr = controller;
              },
            );

          }
      ),
    );
  }
}
