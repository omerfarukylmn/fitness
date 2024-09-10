import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';


class ActivityInProgressScreen extends StatefulWidget {
  final String activity;

  ActivityInProgressScreen({required this.activity});

  @override
  _ActivityInProgressScreenState createState() =>
      _ActivityInProgressScreenState();
}

class _ActivityInProgressScreenState extends State<ActivityInProgressScreen> {
  List<LatLng> _points = [];
  Position? _currentPosition;
  final MapController _mapController = MapController();
  Timer? _timer;
  double _totalDistance = 0.0;
  DateTime _startTime = DateTime.now();
  Duration _elapsedTime = Duration.zero;
  late String _activityId;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    _startTimer();
    _createActivityRecord();
  }

  Future<void> _createActivityRecord() async {
    try {
      final docRef =
          await FirebaseFirestore.instance.collection('activities').add({
        'activity': widget.activity,
        'distance': 0.0, 
        'elapsed_time': 0, 
        'timestamp': Timestamp.now(),
      });
      setState(() {
        _activityId = docRef.id;
      });
    } catch (e) {
      print('Error creating activity record: $e');
    }
  }

  Future<void> _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
    setState(() {
      _currentPosition = position;
      _points.add(LatLng(position.latitude, position.longitude));
    });

    Geolocator.getPositionStream(
      locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position newPosition) {
      setState(() {
        _currentPosition = newPosition;
        _points.add(LatLng(newPosition.latitude, newPosition.longitude));
        if (_points.length > 1) {
          _totalDistance += Geolocator.distanceBetween(
            _points[_points.length - 2].latitude,
            _points[_points.length - 2].longitude,
            _points.last.latitude,
            _points.last.longitude,
          );
        }
        
        FirebaseFirestore.instance
            .collection('activities')
            .doc(_activityId)
            .update({
          'distance': _totalDistance / 1000, 
        });
      });
    });
  }

  void _startTimer() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = DateTime.now().difference(_startTime);
      });
    });
  }

  Future<void> _saveActivityToFirestore() async {
    try {
      await FirebaseFirestore.instance
          .collection('activities')
          .doc(_activityId)
          .update({
        'elapsed_time': _elapsedTime.inSeconds,
      });
    } catch (e) {
      print('Error saving activity: $e');
    }
  }

  void _stopActivity() async {
    _timer?.cancel();
    await _saveActivityToFirestore();
   
    Navigator.pushNamed(
      context,
      '/activitySummary',
      arguments: {
        'activityId': 'geçerli_aktivite_id',
        'elapsedTime': Duration(hours: 1, minutes: 30),
      },
    ).then((_) {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacementNamed(context, '/activityHistory');
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.activity} Activity in Progress'),
        actions: [
          IconButton(
            icon: Icon(Icons.stop),
            onPressed: _stopActivity,
            tooltip: 'Finish',
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _currentPosition != null
                  ? LatLng(
                      _currentPosition!.latitude, _currentPosition!.longitude)
                  : LatLng(0, 0),
              zoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _points,
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  ),
                ],
              ),
              MarkerLayer(
                markers: _currentPosition != null
                    ? [
                        Marker(
                          point: LatLng(_currentPosition!.latitude,
                              _currentPosition!.longitude),
                          child: Icon(Icons.location_on, color: Colors.red),
                        ),
                      ]
                    : [],
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Activity: ${widget.activity}',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  'Total Distance: ${(_totalDistance / 1000).toStringAsFixed(2)} km',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  'Elapsed Time: ${_formatDuration(_elapsedTime)}',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  'Current Location: Lat: ${_currentPosition?.latitude.toStringAsFixed(5)}, '
                  'Lng: ${_currentPosition?.longitude.toStringAsFixed(5)}',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _stopActivity,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.red,
              ),
              child: Text(
                'Finish',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
