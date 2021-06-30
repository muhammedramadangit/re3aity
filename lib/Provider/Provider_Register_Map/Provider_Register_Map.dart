import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProviderRegisterMap extends StatefulWidget {
  @override
  _ProviderRegisterMapState createState() => _ProviderRegisterMapState();
}

class _ProviderRegisterMapState extends State<ProviderRegisterMap> {
  LocationResult _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LocationPicker(
        "AIzaSyCkGjXfjXliwvuLfoPppuvShXZtlkzsTCY",
        automaticallyAnimateToCurrentLocation: true,
        appBarColor: Colors.transparent,
        initialCenter: LatLng(31.045145, 31.394224),
        layersButtonEnabled: true,
        initialZoom: 15,
        myLocationButtonEnabled: true,
        requiredGPS: true,


      ),
    );
  }
}
