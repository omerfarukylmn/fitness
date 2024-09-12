import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final MapController mapController;
  final List<LatLng> points;
  final Position? currentPosition;

  MapWidget({required this.mapController, required this.points, required this.currentPosition});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: currentPosition != null ? LatLng(currentPosition!.latitude, currentPosition!.longitude) : LatLng(0, 0),
        zoom: 15.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: points,
              strokeWidth: 4.0,
              color: Colors.blue,
            ),
          ],
        ),
        if (currentPosition != null)
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(currentPosition!.latitude, currentPosition!.longitude),
                child: Icon(Icons.location_on, color: Colors.red),
              ),
            ],
          ),
      ],
    );
  }
}