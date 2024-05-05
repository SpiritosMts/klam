import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; //import from pub.dev
import '../bindings.dart';
import '../styles.dart';
import 'mapCtr.dart';
import 'mapVoids.dart';

class GoogleMapMarker extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapPickerCtr>(

         //init: MapPickerCtr(),
        initState: (_) {
          mapsCtr.getSavedLocation();
        },
        builder: (ctr) => Scaffold(
              body: Container(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ///map
                    GoogleMap(
                      zoomControlsEnabled: false,
                      onTap: (p) {
                        ctr.setMarker(p.latitude, p.longitude);
                        moveCamPosTo(mapsCtr.gMapctr,animateZoom,p.latitude, p.longitude);
                      },
                      onMapCreated: (GoogleMapController controller) {
                        mapsCtr.gMapctr.complete(controller);
                        //  setDarkMap(getCtrlOnNext.gMapctr);

                      },
                      initialCameraPosition: (ctr.lati * ctr.lngi != 0.0) ?
                           CameraPosition(target: LatLng(ctr.lati, ctr.lngi), zoom: 16.0)
                          : userCurrentPos,
                      markers: ctr.markers.values.toSet(),
                    ),

                    ///save
                    Container(
                      // key: ttrCtr.addItemKey,
                      height: 40.0,
                      width: 130.0,
                      child: FittedBox(
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            ctr.save();

                          },
                          backgroundColor: blueCol,
                          label: Row(
                            children: [
                              Text(
                                'Save'.tr,
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 5),

                              Icon(Icons.location_on,color: Colors.white,),

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                  ],
                ),
              ),
            ));
  }
}
