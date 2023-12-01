import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/cafeterias/cafeterias_bloc.dart';

class ImagePickerCamera extends StatelessWidget {
  const ImagePickerCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(child: Text("Take picture"), onPressed: (){
        context.read<CafeteriasBloc>().takePickImage().then((value) =>  Navigator.of(context).pop() );
      },),
    );
  }
}