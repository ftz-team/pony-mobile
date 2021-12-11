import 'dart:async';

import 'package:cybergarden_app/UI/components/BottomSheets/CollectorBottomSheet.dart';
import 'package:cybergarden_app/UI/components/BottomSheets/WashBottomSheet.dart';
import 'package:cybergarden_app/UI/components/cards/CategoryCard.dart';
import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/UI/containers/Filters/FiltersPage.dart';
import 'package:cybergarden_app/UI/containers/Map/CollectorMarker.dart';
import 'package:cybergarden_app/UI/containers/Map/CollectorsList.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/bloc/WashesBloc.dart';
import 'package:cybergarden_app/data/models/WashModel.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin  {
  List<WashModel> collectors = [];
  late StreamSubscription _subscription;
  late StreamSubscription _subscription2;

  final List filters = [
    'Все',
    'Для пластика',
    'Для стекла',
    'Для бумаги',
    'Для батареек'
  ];
  Set<Marker> _markers = {};
  int activeId = -1;
  bool openedFilters = false;

  toogleOpened() {
    this.setState(() {
      openedFilters = !openedFilters;
    });
  }

  late GoogleMapController mapController;
  String _mapStyle = "";
  final LatLng _center = const LatLng(45.521563, -122.677433);
  Location _location = Location();

  void onMarkerTap(WashModel wash) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(wash.point.lat, wash.point.long),
            zoom: 15),
      ),
    );
    this.setState(() {
      activeId = wash.id;
      init();
    });
    Future.delayed(const Duration(milliseconds: 2100), () {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(125.0),
          ),
          builder: (context) {
            return WashBottomSheet(context, wash);
          });
    });
  }

  void init() async {
    _markers.clear();
    var pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/collectorMarket.png');
    var pinLocationIconActive = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/collectorMarketActive.png');
    var collectorsModels = collectors;
    collectorsModels.forEach((WashModel) {
      _markers.add(Marker(
          markerId: MarkerId(WashModel.id.toString()),
          position: LatLng(WashModel.point.lat, WashModel.point.long),
          icon: activeId == WashModel.id
              ? pinLocationIconActive
              : pinLocationIcon,
          onTap: () {
            onMarkerTap(WashModel);
          }));
    });
    this.setState(() {
      _markers = _markers;
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
    var l = await _location.getLocation();
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
      ),
    );
    init();
  }

  @override
  void initState() {
    _subscription = washesBloc.washesList.listen((data) {
      this.setState(() {
        collectors = data;
      });
      init();
    });
    _subscription2 = washesBloc.activeWash.listen((data) {
      onMarkerTap(data);
    });
    washesBloc.loadWashes();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      this._mapStyle = string;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            defaultHeader("Wash"),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    new CupertinoPageRoute(
                        builder: (context) => FiltersPage()));
              },
              child: new Icon(
                Icons.list,
                color: UIIconColors.active,
                size: 32,
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            myLocationEnabled: true,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    _subscription2.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
