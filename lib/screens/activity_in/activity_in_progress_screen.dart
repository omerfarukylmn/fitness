import 'package:fitness/utils/formatters.dart';
import 'package:fitness/service/location_service.dart';
import 'package:fitness/widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityInProgressScreen extends StatefulWidget {
  final String activity;

  const ActivityInProgressScreen({super.key, required this.activity});

  @override
  _ActivityInProgressScreenState createState() =>
      _ActivityInProgressScreenState();
}

class _ActivityInProgressScreenState extends State<ActivityInProgressScreen> {
  final List<LatLng> _points = [];
  Position? _currentPosition;
  final MapController _mapController = MapController();
  Timer? _timer;
  final double _totalDistance = 0.0;
  DateTime _startTime = DateTime.now();
  Duration _elapsedTime = Duration.zero;
  late String _activityId;

  @override
  void initState() {
    super.initState();
    _initializeActivity();
  }

  Future<void> _initializeActivity() async {
    _currentPosition = await LocationService.getCurrentPosition();
    if (_currentPosition != null) {
      setState(() {
        _points.add(LatLng(_currentPosition!.latitude, _currentPosition!.longitude));
      });
    }
    _startTimer();
    _createActivityRecord();
  }

  Future<void> _createActivityRecord() async {
    try {
      final docRef = await FirebaseFirestore.instance.collection('activities').add({
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

  void _startTimer() {
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = DateTime.now().difference(_startTime);
      });
    });
  }

  Future<void> _saveActivityToFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('activities').doc(_activityId).update({
        'elapsed_time': _elapsedTime.inSeconds,
      });
    } catch (e) {
      print('Error saving activity: $e');
    }
  }

  void _stopActivity() async {
    _timer?.cancel();
    await _saveActivityToFirestore();
    Navigator.pushNamed(context, '/activitySummary', arguments: {
      'activityId': _activityId,
      'elapsedTime': _elapsedTime,
    }).then((_) {
      Future.delayed(const Duration(seconds: 5), () {
        Navigator.pushReplacementNamed(context, '/activityHistory');
      });
    });
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
            icon: const Icon(Icons.stop),
            onPressed: _stopActivity,
            tooltip: 'Finish',
          ),
        ],
      ),
      body: Stack(
        children: [
          MapWidget(
            mapController: _mapController,
            points: _points,
            currentPosition: _currentPosition,
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Activity: ${widget.activity}',
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'Total Distance: ${(_totalDistance / 1000).toStringAsFixed(2)} km',
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'Elapsed Time: ${formatDuration1(_elapsedTime)}',
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'Current Location: Lat: ${_currentPosition?.latitude.toStringAsFixed(5)}, '
                  'Lng: ${_currentPosition?.longitude.toStringAsFixed(5)}',
                  style: const TextStyle(fontSize: 20, color: Colors.black),
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
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.red,
              ),
              child: const Text(
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