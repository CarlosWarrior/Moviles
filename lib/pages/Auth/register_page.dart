import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto/bloc/auth/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final RegExp _emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Registrarse",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Nombre",
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "Nombre",
                        hintText: "Nombre",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Email",
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email",
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese un email";
                        }
                        if (!_emailRegex.hasMatch(value)) {
                          return "Ingrese un email valido";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Contraseña",
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Contraseña",
                      hintText: "Contraseña",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingrese un password";
                      }
                      return null;
                    },
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      AuthRegisterEvent(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Text("REGISTRARSE"),
                ),
              ),
              Text(
                '- O -',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Tienes cuenta?"),
                  TextButton(
                    onPressed: () => {
                      Navigator.of(context).popAndPushNamed('/'),
                    },
                    child: Text("Iniciar Sesión"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
