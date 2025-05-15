import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:abilify/utils/map_utils.dart';

class MapView extends StatefulWidget {
  final List<Marker> markers;
  final Color markerColor;
  final double height;
  final bool showCurrentLocation;
  final Function(GoogleMapController)? onMapCreated;

  const MapView({
    Key? key,
    required this.markers,
    required this.markerColor,
    this.height = 300,
    this.showCurrentLocation = true,
    this.onMapCreated,
  }) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  void _setMarkers() {
    setState(() {
      _markers = widget.markers.toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: MapUtils.getDefaultCameraPosition(),
        markers: _markers,
        myLocationEnabled: widget.showCurrentLocation,
        myLocationButtonEnabled: widget.showCurrentLocation,
        zoomControlsEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          if (widget.onMapCreated != null) {
            widget.onMapCreated!(controller);
          }
        },
      ),
    );
  }
} 