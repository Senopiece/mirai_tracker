import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mirai_tracker/services/mirai_tracker.dart';

import 'utils/accurate_poller.dart';

class _MapWidget extends StatefulWidget {
  final LatLng point;

  const _MapWidget(this.point, {Key? key}) : super(key: key);

  @override
  State<_MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<_MapWidget> {
  MapController mapController = MapController();

  @override
  void didUpdateWidget(covariant _MapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.point != widget.point) {
      mapController.move(
        widget.point,
        mapController.zoom,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: widget.point,
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
              point: widget.point,
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
    );
  }
}

class TrackerMap extends StatefulWidget {
  final MiraiTracker tracker;

  const TrackerMap({super.key, required this.tracker});

  @override
  State<TrackerMap> createState() => _TrackerMapState();
}

class _TrackerMapState extends State<TrackerMap> {
  late AccuratePoller<LocationInfo> poller;
  late Timer actualizator;

  void _createPoller() {
    poller = AccuratePoller<LocationInfo>(
      const Duration(minutes: 1),
      () async {
        final res =
            await widget.tracker.getNearestLocationByTime(DateTime.now());

        // TODO: remove when devices fix this
        return res.copyWith(
          loc: res.loc.copyWith(
            lat: res.loc.lon,
            lon: res.loc.lat,
          ),
        );
      },
    );

    actualizator = Timer.periodic(
      const Duration(minutes: 1),
      (_) => poller.poll(),
    );
  }

  @override
  void initState() {
    super.initState();
    _createPoller();
    poller.poll();
  }

  @override
  void reassemble() {
    super.reassemble();
    actualizator.cancel();
    _createPoller();
    poller.poll();
  }

  @override
  void dispose() {
    super.dispose();
    actualizator.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocationInfo>(
      stream: poller.responsesStream,
      builder: (context, snap) {
        late Widget content;

        if (snap.hasData) {
          content = Stack(
            children: [
              _MapWidget(snap.data!.loc.asLatLng),
              Align(
                alignment: Alignment.topCenter,
                child: FractionalTranslation(
                  translation: const Offset(0, 0.5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 1,
                      horizontal: 5,
                    ),
                    child: Text(
                      DateFormat('yyyy-MM-dd HH:mm:ss').format(
                          snap.data!.timestamp.copyWith(isUtc: true).toLocal()),
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          content = Center(
            child: Icon(
              Icons.location_off,
              size: 70,
              color: Theme.of(context).disabledColor,
            ),
          );
        }

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.transparent,
              width: 2,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(10),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 100,
              minHeight: 100,
              maxWidth: 500,
              maxHeight: 500,
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: content,
            ),
          ),
        );
      },
    );
  }
}
