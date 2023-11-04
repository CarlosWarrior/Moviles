import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias_bloc.dart';
class CameraApp extends StatefulWidget {
  final CameraDescription camera;
  CameraApp({required this.camera, super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
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
            return Container();
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

  