import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lastre3ayty/theme/color.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> _marker = {};
  BitmapDescriptor mapMarker;
  GoogleMapController mapController;
  String searchAddress;

  // @override
  // void initState() {
  //   setCustomMarker();
  //   super.initState();
  // }
  //
  // void setCustomMarker() async {
  //   mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), "assets/icons/markerlocation.png");
  // }

  void _onMapCreation(GoogleMapController controller) {
    setState(() {
      _marker.add(
        Marker(
            markerId: MarkerId("id=1"),
            position: LatLng(31.045145, 31.394224),
            // icon: mapMarker,
            infoWindow: InfoWindow(title: "رعايتي", snippet: "تطبيق جوال")),
      );

      mapController = controller;
    });
  }

  searchAndNavigate() {
    // Geolocator().placemarkFromAddress(searchAddress).then((value) {
    //   mapController.animateCamera(CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //       target: LatLng(value[0].position.latitude, value[0].position.longitude),
    //       zoom: 15,
    //     )
    //   ));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreation,
              markers: _marker,
              initialCameraPosition: CameraPosition(
                target: LatLng(31.045145, 31.394224),
                zoom: 15,
              ),
            ),

            //============ Search appBar ==================
            Positioned(
              top: 30,
              left: 15,
              right: 15,
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: ThemeColor.darkerGreyText,
                      ),
                      onPressed: () => Navigator.pop(context)),
                  Expanded(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "أدخل العنوان...",
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 14),
                            contentPadding: EdgeInsets.only(right: 15, top: 10),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: searchAndNavigate,
                              iconSize: 30,
                            )),
                        onChanged: (value) {
                          setState(() {
                            searchAddress = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
