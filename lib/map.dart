import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapWidget(this.latitude, this.longitude, {Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  MapController mapController = MapController();

  @override
  void didUpdateWidget(covariant MapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.latitude != widget.latitude ||
        oldWidget.longitude != widget.longitude) {
      mapController.move(
        LatLng(widget.latitude, widget.longitude),
        mapController.zoom,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 100,
          minHeight: 100,
          maxWidth: 500,
          maxHeight: 500,
        ),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: LatLng(widget.latitude, widget.longitude),
              zoom: 14.8,
              maxZoom: 18.0,
              minZoom: 2.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.mirai.app',
              ),
              MarkerLayer(
                markers: [
                  // TODO: mark the certainity radius (that blue circle around)
                  Marker(
                    point: LatLng(widget.latitude, widget.longitude),
                    rotate: true,
                    // these are pretty good, but can be better (the position somewhy is not the most exactly at the steeple)
                    width:
                        42.7, // ya, this numbers matter (for the actual coordinate to be exactly at the steeple, as well as for rotation to be exactly around the steeple)
                    height: 80,
                    // ya, stack matters (the same reason to be exactly at the steeple)
                    builder: (context) => const Stack(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 40,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
