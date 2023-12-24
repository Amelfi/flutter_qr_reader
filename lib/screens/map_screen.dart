import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  late MapType mapType = MapType.normal;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final dynamic receivedArgs = ModalRoute.of(context)!.settings.arguments;
    final ScanModel scan = receivedArgs; // Casting to ScanModel

    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 14.4746,
    );

    //Marcadores

    Set<Marker> markers = Set<Marker>();
    markers.add(
      Marker(markerId: MarkerId('geo-location'), position: scan.getLatLng()),
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Mapa', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              await controller
                  .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: scan.getLatLng(),
                zoom: 14.4746,
              )));
            },
            icon: const Icon(Icons.directions),
            color: Colors.white,
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        markers: markers,
        mapType: mapType,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mapType == MapType.normal) {
            mapType = MapType.hybrid;
          } else {
            mapType = MapType.normal;
          }

          setState(() {
            
          });
        },
        child: const Icon(Icons.layers, color: Colors.white),
      ),
    );
  }
}
