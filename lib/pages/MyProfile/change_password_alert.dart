import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/auth/auth_bloc.dart';

class ChangePasswordAlert extends StatefulWidget {
  final String id;
  const ChangePasswordAlert({super.key, required this.id});

  @override
  State<ChangePasswordAlert> createState() => _ChangePasswordAlertState();
}

class _ChangePasswordAlertState extends State<ChangePasswordAlert> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cambiar contraseña'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: _newPasswordController,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Nueva contraseña',
            ),
          ),
          TextField(
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Confirmar contraseña',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (_newPasswordController.text !=
                _confirmPasswordController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Las contraseñas no coinciden'),
                ),
              );
              return;
            }
            BlocProvider.of<AuthBloc>(context).add(
              ChangePasswordEvent(
                password: _newPasswordController.text,
              ),
            );
            Navigator.of(context).pop();
          },
          child: Text('Cambiar'),
        ),
      ],
    );
  }
}
