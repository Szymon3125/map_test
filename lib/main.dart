import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

void main() {
  runApp(const MapTest());
}

class MapTest extends StatelessWidget {
  const MapTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MapTest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapboxMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        accessToken: const String.fromEnvironment('SDK_REGISTRY_TOKEN'),
        initialCameraPosition: const CameraPosition(target: LatLng(0, 0)),
        onMapCreated: _onMapCreated,
      ),
    );
  }

  Future<void> _onMapCreated(MapboxMapController controller) async {
    mapController = controller;
  }
}
