import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController myController;
  LatLng center = const LatLng(10.854031830311186, 106.62789277065008);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    const String markerIdVal = 'm1';
    const MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        center.latitude,
        center.longitude,
      ),
      infoWindow: const InfoWindow(
          title: 'CÔNG TY TNHH THƯƠNG MẠI VÀ DỊCH VỤ NINA',
          snippet:
              'Lầu 3, Tòa nhà SaigonTel, Lô 46, CVPM Quang Trung, P. Tân Chánh Hiệp, Q. 12, TP HCM'),
    );

    setState(() {
      markers[markerId] = marker;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _onMapCreated(GoogleMapController controller) {
      myController = controller;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width, // or use fixed size like 200
          height: MediaQuery.of(context).size.height - 400,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            markers: markers.values.toSet(),
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: 15.0,
            ),
          ),
        )
      ],
    );
  }
}
