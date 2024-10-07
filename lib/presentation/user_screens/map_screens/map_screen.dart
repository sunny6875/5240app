import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Use latlong2 for geolocation
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:project_5240_frontend/presentation/user_screens/map_screens/controller/map_controller.dart';
import 'package:project_5240_frontend/utils/extension.dart'; // For state management

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MapControllerX mapControllerX = Get.put(MapControllerX());
    debugPrint("==============>${mapControllerX.locationName.value}");
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            mapControllerX.centerLocationForZoom.value
                ? mapControllerX.locationName.value
                : 'Map Screen',
            style: const TextStyle(
              fontFamily: "inter",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Obx(
            () => mapControllerX.isLoading.value
                ? const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: NutsActivityIndicator(
                      activeColor: Colors.white,
                      inactiveColor: AppColors.green,
                      tickCount: 24,
                      relativeWidth: 0.4,
                      radius: 15,
                      startRatio: 0.7,
                      animationDuration: Duration(milliseconds: 500),
                    ),
                  )
                : const SizedBox(),
          )
        ],
      ),
      body: Stack(
        children: [
          // FlutterMap with GetX Observables
          Obx(
            () => FlutterMap(
              mapController: mapControllerX.mapController.value,
              options: MapOptions(
                initialZoom:
                    mapControllerX.centerLocationForZoom.value ? 16 : 4,
                initialCenter: const LatLng(20.5937, 78.9629),
                onTap: (tapPosition, latlng) {
                  mapControllerX.moveTo(latlng);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: "com.example.project_5240_frontend",
                ),
                // Adding a marker
                MarkerLayer(
                  markers: [
                    Marker(
                      point: (mapControllerX.currentPosition.value != null &&
                              mapControllerX.currentPosition.value != null)
                          ? LatLng(
                              mapControllerX.currentPosition.value!.latitude,
                              mapControllerX.currentPosition.value!.longitude,
                            )
                          : const LatLng(20.5937, 78.9629), // Marker position
                      width: 80,
                      height: 80,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                // Add a polygon
                PolygonLayer(
                  polygons: [
                    Polygon(
                      points: (mapControllerX.currentPosition.value != null &&
                              mapControllerX.currentPosition.value != null)
                          ? [
                              LatLng(
                                mapControllerX.currentPosition.value!.latitude,
                                mapControllerX.currentPosition.value!.longitude,
                              ),
                            ]
                          : [const LatLng(20.5937, 78.9629)],
                      borderColor: Colors.blue,
                      borderStrokeWidth: 3,
                      color: Colors.blue.withOpacity(0.3),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Zoom controls on the map
          Positioned(
            right: 10,
            top: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () => mapControllerX.zoomIn(),
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () => mapControllerX.zoomOut(),
                  child: const Icon(Icons.zoom_out),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () => mapControllerX.getCurrentLocationDetails(),
                  child: const Icon(Icons.location_searching),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
