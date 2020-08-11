import 'dart:async';

import 'package:KwiBerry/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/cache_fetcher.dart';

const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

class LocationScreen extends StatefulWidget {
  static final String routeName = '/locationscreen';
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  TextEditingController _textController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  LocationData locData;
  Location loc = new Location();
  String locationText;
  //Google Maps based parameters
  CameraPosition position;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loc.changeSettings(interval: 5000);
    locData = Provider.of<CacheFetcher>(context, listen: false).locData;
    position = CameraPosition(
        target: LatLng(locData.latitude, locData.longitude),
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING);
    loc.onLocationChanged.listen((LocationData locationData) {
      locData = locationData;
      updateMap();
    });
  }

  void updateMap() async {
    final Geolocator _geolocator = Geolocator();
    position = CameraPosition(
        target: LatLng(locData.latitude, locData.longitude),
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
    List<Placemark> newPlace = await _geolocator.placemarkFromCoordinates(
        locData.latitude, locData.longitude);
    Placemark placeMark = newPlace[0];
    String name = placeMark.name;
    // String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    // String subAdministrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;
    // String subThoroughfare = placeMark.subThoroughfare;
    String thoroughfare = placeMark.thoroughfare;
    locationText =
        "$name, $thoroughfare, $locality, $administrativeArea, $postalCode, $country";
    if (locationText != _textController.text) {
      _textController.clear();
      _textController.text = locationText;
    }
    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: GoogleMap(
          initialCameraPosition: position,
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
        )),
        TextField(
          minLines: 2,
          maxLines: 5,
          controller: _textController,
        ),
        RaisedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName,
                  arguments: locationText);
            },
            child: Text('Proceed to Restaurants')),
      ],
    ));
  }
}
