import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:proyecto/models/cafeteria.dart';

part 'cafeterias_event.dart';
part 'cafeterias_state.dart';

class CafeteriasBloc extends Bloc<CafeteriasEvent, CafeteriasState> {
  CafeteriasBloc() : super(CafeteriasInitial()) {
    on<GetCafeteriasEvent>(_getCafeterias);
    on<SearchCafeteriasEvent>(_searchCafeterias);
    on<SelectCafeteriasEvent>(_selectCafeteria);
    on<ViewMenuEvent>(_viewMenu);
  }
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Cafeteria> _cafeterias = [];
  Cafeteria? _cafeteria = null;

  void setCafeteria(Cafeteria value) => _cafeteria = value;

  bool _contains(Cafeteria cafe) {
    return cafe.title
        .toString()
        .toLowerCase()
        .contains(_query.text.toLowerCase());
  }

  TextEditingController _query = TextEditingController();

  double _foodTasteRating = 0.0;
  double _foodPriceRating = 0.0;
  TextEditingController foodComment = TextEditingController();
  rateTaste(double rating) {
    _foodTasteRating = rating;
  }

  ratePrice(double rating) {
    _foodPriceRating = rating;
  }

  pushFoodRating() {
    print(
        "${foodComment.text} , ${_foodTasteRating.toString()}, ${_foodPriceRating.toString()}");
    _foodTasteRating = 0.0;
    _foodPriceRating = 0.0;
  }

  bool permissionsAccepted = false;
  Future<void> requestPermissions() async {
    PermissionStatus cameraPermission = await Permission.camera.status;
    if (cameraPermission.isDenied) {
      await Permission.camera.request();
      cameraPermission = await Permission.camera.status;
      if (cameraPermission.isDenied) {
        await openAppSettings();
      }
    } else if (cameraPermission.isPermanentlyDenied) {
      await openAppSettings();
    }

    PermissionStatus mediaLibraryPermission = await Permission.photos.status;
    if (mediaLibraryPermission.isDenied) {
      await Permission.mediaLibrary.request();
      mediaLibraryPermission = await Permission.mediaLibrary.status;
      if (mediaLibraryPermission.isDenied) {
        await openAppSettings();
      }
    } else if (mediaLibraryPermission.isPermanentlyDenied) {
      await openAppSettings();
    }

    PermissionStatus photosPermission = await Permission.photos.status;
    if (photosPermission.isDenied) {
      await Permission.photos.request();
      photosPermission = await Permission.photos.status;
      if (photosPermission.isDenied) {
        await openAppSettings();
      }
    } else if (photosPermission.isPermanentlyDenied) {
      await openAppSettings();
    }

    PermissionStatus storagePermission;
    // Don't ask for storage permission on Android 13
    if (defaultTargetPlatform == TargetPlatform.android) {
      var androidVersion =
          int.parse((await DeviceInfoPlugin().androidInfo).version.release);

      if (androidVersion < 13) {
        storagePermission = await Permission.storage.status;
        if (storagePermission.isDenied) {
          await Permission.storage.request();
          storagePermission = await Permission.storage.status;
          if (storagePermission.isDenied) {
            await openAppSettings();
          }
        } else if (storagePermission.isPermanentlyDenied) {
          await openAppSettings();
        }
      } else {
        storagePermission = PermissionStatus.granted;
      }
    } else {
      storagePermission = await Permission.storage.status;
      if (storagePermission.isDenied) {
        await Permission.storage.request();
        storagePermission = await Permission.storage.status;
        if (storagePermission.isDenied) {
          await openAppSettings();
        }
      } else if (storagePermission.isPermanentlyDenied) {
        await openAppSettings();
      }
    }

    this.permissionsAccepted = cameraPermission.isGranted &&
        storagePermission.isGranted &&
        (photosPermission.isGranted || photosPermission.isLimited) &&
        mediaLibraryPermission.isGranted;
  }

  Future<void> _getCafeterias(GetCafeteriasEvent event, Emitter emit) async {
    emit(CafeteriasLoadingState());
    try {
      print("fetching");
      CollectionReference<Map<String, dynamic>> cafesCollection =
          firestore.collection("cafeterias");
      await cafesCollection
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> cafesSnapshot) {
        _cafeterias = cafesSnapshot.docs
            .map((QueryDocumentSnapshot<Map<String, dynamic>> cafeSnapshot) {
          Map<String, dynamic> cafeMap = cafeSnapshot.data();
          cafeMap["id"] = cafeSnapshot.id;
          return Cafeteria.fromMap(cafeMap);
        }).toList();
      });
      emit(CafeteriasSuccessState(cafeteriasList: _cafeterias));
    } catch (e) {
      debugPrint(e.toString());
      emit(CafeteriasErrorState());
    }
  }

  void _searchCafeterias(SearchCafeteriasEvent event, Emitter emit) {
    try {
      if (event.query.isEmpty) {
        emit(CafeteriasSuccessState(cafeteriasList: _cafeterias));
      } else {
        var filtered = _cafeterias.where((element) => _contains(element));
        emit(CafeteriasSuccessState(cafeteriasList: filtered.toList()));
      }
    } catch (e) {
      emit(CafeteriasErrorState());
    }
  }

  void _selectCafeteria(SelectCafeteriasEvent event, Emitter emit) {
    emit(SelectCafeteriaState(cafeteria: _cafeteria!));
  }

  void _viewMenu(ViewMenuEvent event, Emitter emit) {
    emit(ViewMenuState(cafeteria: _cafeteria!));
  }
}
