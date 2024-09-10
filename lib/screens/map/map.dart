import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // latlong2 kütüphanesi güncellenmiş
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ActivityMapScreen extends StatefulWidget {
  @override
  _ActivityMapScreenState createState() => _ActivityMapScreenState();
}

class _ActivityMapScreenState extends State<ActivityMapScreen> {
  final MapController _mapController = MapController();
  List<LatLng> _points = [];
  Position? _currentPosition;
  bool _isTracking = false;
  Timer? _timer;
  double _totalDistance = 0.0;
  DateTime _startTime = DateTime.now();
  double _averageSpeed = 0.0;
  String _weather = 'Fetching...';

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    _getWeatherData();
  }

  Future<void> _getCurrentPosition() async {
    _currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      if (_currentPosition != null) {
        _points.add(
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude));
      }
    });

    if (_isTracking) {
      _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) async {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          _currentPosition = position;
          _points.add(LatLng(position.latitude, position.longitude));
          _updateStats();
        });
      });
    }
  }

  void _startTracking() {
    setState(() {
      _isTracking = true;
      _startTime = DateTime.now();
      _getCurrentPosition();
    });
  }

  void _stopTracking() {
    setState(() {
      _isTracking = false;
      _timer?.cancel();
      _saveActivityData();
    });
  }

  Future<void> _saveActivityData() async {
    await FirebaseFirestore.instance.collection('activities').add({
      'start_time': _startTime,
      'end_time': DateTime.now(),
      'total_distance': _totalDistance,
      'average_speed': _averageSpeed,
    });
  }

  Future<void> _getWeatherData() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final apiKey = 'YOUR_API_KEY'; // Replace with your OpenWeatherMap API key
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    setState(() {
      _weather = '${data['weather'][0]['main']} ${data['main']['temp']}°C';
    });
  }

  void _updateStats() {
    if (_points.length < 2) return;

    double distance = 0.0;
    for (int i = 1; i < _points.length; i++) {
      distance += Geolocator.distanceBetween(
        _points[i - 1].latitude,
        _points[i - 1].longitude,
        _points[i].latitude,
        _points[i].longitude,
      );
    }

    final elapsedTime =
        DateTime.now().difference(_startTime).inSeconds / 3600.0;
    setState(() {
      _totalDistance = distance / 1000.0; // Convert to km
      _averageSpeed = _totalDistance / elapsedTime; // km/h
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
        title: Text('Activity Tracking'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(),
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
                        
                       
                      ]
                    : [],
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 10.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Distance: ${_totalDistance.toStringAsFixed(2)} km',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text(
                    'Elapsed Time: ${DateTime.now().difference(_startTime).inMinutes} min',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text('Average Speed: ${_averageSpeed.toStringAsFixed(2)} km/h',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                Text('Weather: $_weather',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 10.0,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _startTracking,
                  child: Text('Start'),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _stopTracking,
                  child: Text('Stop'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
