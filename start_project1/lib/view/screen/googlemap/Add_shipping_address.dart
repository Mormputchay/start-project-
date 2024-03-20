// ignore_for_file: camel_case_types
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../color.dart';
import '../../widget/round_field_in_google.dart';

class Add_shipping_address extends StatefulWidget {
  const Add_shipping_address({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Add_shipping_addressState createState() => _Add_shipping_addressState();
}

class _Add_shipping_addressState extends State<Add_shipping_address> {
  final double _initFabHeight = 350.0;
  double fabHeight = 0;
  final double _panelHeightClosed = 95.0;

  @override
  void initState() {
    super.initState();
    _init();
    fabHeight = _initFabHeight;
  }

  TextEditingController txtFloor = TextEditingController();
  TextEditingController txthouse = TextEditingController();
  TextEditingController txtNote = TextEditingController();
  final Completer<GoogleMapController> _googleMapController = Completer();
  late GoogleMapController controller;
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  LatLng? _currentLocation;
  FocusNode fieldFloor = FocusNode();
  FocusNode fieldNote = FocusNode();
  FocusNode fieldHouse = FocusNode();
  final List<String> items = ['Home', 'Work', 'School', 'Other'];
  int selectedIndex = -1;

  GoogleMapController? _mapController;
  late String _draggedAddress = "";

  @override
  _init() {
    //set default latlng for camera position
    _defaultLatLng = const LatLng(37.42796133580664, -122.085749655962);
    _draggedLatlng = _defaultLatLng;
    _cameraPosition = CameraPosition(
      target: _defaultLatLng, zoom: 14.4746, // number of map view
    );

    //map will redirect to my current location when loaded
    _gotoUserCurrentPosition();
  }

  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  var isButtonClicked = false;
  @override
  Widget build(BuildContext context) {
    var panelHeightOpen = MediaQuery.of(context).size.width;
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel(
        maxHeight: panelHeightOpen,
        minHeight: _panelHeightClosed,
        parallaxEnabled: true,
        parallaxOffset: .5,
        body: Stack(
          fit: StackFit.expand,
          children: [
            GoogleMap(
              initialCameraPosition: _cameraPosition!,
              //initialize camera position for map
              mapType: MapType.normal,
              onCameraIdle: () {
                _getAddress(_draggedLatlng);
              },
              onCameraMove: (cameraPosition) {
                _draggedLatlng = cameraPosition.target;
              },
              onMapCreated: (GoogleMapController controller) {
                //this function will trigger when map is fully loaded
                if (!_googleMapController.isCompleted) {
                  _googleMapController.complete(controller);
                }
              },
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: SvgPicture.asset(
                        "assets/svg/back.svg",
                        width: 18,
                        height: 18,
                        fit: BoxFit.contain,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Center(
                child: IconButton(
                    onPressed: () {
                      if (_currentLocation != null && _mapController != null) {
                        _mapController!.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: _currentLocation!,
                              zoom: 15,
                            ),
                          ),
                        );
                      }
                    },
                    icon: SvgPicture.asset("assets/svg/map.svg")),
              ),
            )
          ],
        ),
        panelBuilder: (sc) => MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  button_Display_map(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: RoundFieldGoogle(
                      controller: txtFloor,
                      hintText: 'Floor/Unit #',
                      focusNode: fieldFloor,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(fieldNote);
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: RoundFieldGoogle(
                      controller: txtNote,
                      hintText: 'Note',
                      focusNode: fieldNote,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(fieldHouse);
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add a label",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: isSelectOther ? 110 : 30,
                    child: Stack(
                      children: [
                        ListAdd_a_label(),
                        Container(
                          child: isSelectOther
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 50),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: RoundFieldGoogle(
                                              controller: txthouse,
                                              hintText: "someone's house",
                                              focusNode: fieldHouse,
                                              keyboardType: TextInputType.text,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: MaterialButton(
                      minWidth: double.maxFinite,
                      height: 45,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: TColor.primary,
                      onPressed: () {},
                      child: Text(
                        'Save'.toUpperCase(),
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            )),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ListView ListAdd_a_label() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                child: MaterialButton(
                  minWidth: 50,
                  height: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: selectedIndex == index ? TColor.primary : TColor.white,
                  onPressed: () {
                    setState(() {
                      selectedIndex = index;
                      if (index == 3) {
                        isSelectOther = true;
                      } else {
                        isSelectOther = false;
                      }
                    });
                  },
                  child: Text(items[index]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  GestureDetector button_Display_map() {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          width: double.maxFinite,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 4, offset: Offset(1, 3))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                    child: SvgPicture.asset(
                  "assets/svg/map.svg",
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _draggedAddress,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              "Phnom Penh",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SvgPicture.asset(
                    "assets/svg/edit.svg",
                    width: 15,
                    height: 15,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isSelectOther = false;
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 17.5)));
    //every time that we dragged pin , it will list down the address here
    await _getAddress(position);
  }

  Future _getAddress(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    String addresStr =
        "${address.street}, ${address.locality}, ${address.administrativeArea}, ${address.country}";
    setState(() {
      _draggedAddress = addresStr;
    });
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      print("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        print("user denied location permission");
      }
    }

    //check if user denied permission forever
    if (locationPermission == LocationPermission.deniedForever) {
      print("user denied permission forever");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
