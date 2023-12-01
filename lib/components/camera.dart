import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias/cafeterias_bloc.dart';
import 'package:proyecto/bloc/image_picker_camera.dart';
class Camera extends StatefulWidget {
  final CameraDescription camera;
  Camera({required this.camera, super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.max, imageFormatGroup: ImageFormatGroup.jpeg);
    controller.initialize().then((_) {
      if (!mounted) {
        print("Camera not mounted");
        return;
      }
      print("Camera mounted");
      setState(() {});
    }).catchError((Object e) {
      print("Camera error");
      print(e);
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("Camera access denied");
            print(e);
            break;
          default:
            print("Camera error");
            print(e);
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _captureAndUpload() async {
    print("Capturing image");
    try {
      controller.takePicture()
        .then((XFile imageFile){
          print(imageFile);
          return context.read<CafeteriasBloc>().takeImage(imageFile);
        }).then((value){    
          print("popping");
          Navigator.of(context).pop();
        });
        
    } catch (e) {
      print("Error capturing and uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        dispose();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Toma una foto'),
        ),
        body: Builder(builder: (context) {
          if (!controller.value.isInitialized) {
            return Container(
              child: ImagePickerCamera(),
            );
          }
          return CameraPreview(controller);
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: _captureAndUpload,
          child: Icon(Icons.camera_alt),
        ),
      ),
    );
  }
}

  