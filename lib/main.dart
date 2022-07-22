import 'dart:math';

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

class _MapScreenState extends State<MapScreen>
    with
        // ignore: prefer_mixin
        WidgetsBindingObserver {
  late MapboxMapController mapController;
  late List<LatLng> coordList;
  bool refreshAllChildrenAfterWakeup = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    if (refreshAllChildrenAfterWakeup) {
      refreshAllChildrenAfterWakeup = false;
      _rebuildAllChildren(context);
    }
    return Scaffold(
      body: MapboxMap(
        accessToken: const String.fromEnvironment('SDK_REGISTRY_TOKEN'),
        initialCameraPosition: const CameraPosition(target: LatLng(0, 0)),
        onMapCreated: _onMapCreated,
        onMapClick: (Point<double> point, LatLng latlng) {
          print('Hello there!');
        },
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        refreshAllChildrenAfterWakeup = true;
      });
    }
  }

  void _rebuildAllChildren(BuildContext context) {
    void rebuild(Element element) {
      element.markNeedsBuild();
      element.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  Future<void> _onMapCreated(MapboxMapController controller) async {
    mapController = controller;
  }
}
