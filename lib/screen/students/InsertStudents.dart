// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class InsertStudents extends StatefulWidget {
  const InsertStudents({Key? key}) : super(key: key);
  @override
  State<InsertStudents> createState() => _InsertStudents();
}

class _InsertStudents extends State<InsertStudents> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _carnetController = TextEditingController();

  bool isEmailValid(String email) {
    // Expresión regular para verificar un correo electrónico
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  bool isNumberValid(String number) {
    // Verificar si el valor es un número
    return int.tryParse(number) != null;
  }

  Future<void> _guardarEstudiante() async {
    final nombre = _nombreController.text;
    final apellido = _apellidoController.text;
    final email = _emailController.text;
    final carnet = _carnetController.text;

    if (nombre.isNotEmpty &&
        apellido.isNotEmpty &&
        email.isNotEmpty &&
        carnet.isNotEmpty) {
      if (isEmailValid(email) && isNumberValid(carnet)) {
        final estudiante = {
          'nombre': nombre,
          'apellido': apellido,
          'email': email,
          'carnet': carnet,
        };

        try {
          final response = await http.post(
            Uri.parse(
                'https://api-android-rivel.onrender.com/addStudent'), // Reemplaza con la URL de tu API
            body: estudiante,
          );

          if (response.statusCode == 200) {
            // Si la solicitud es exitosa
            Fluttertoast.showToast(
              msg: 'Se ha insertado correctamente',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );

            // Cerrar la pantalla actual y volver a la anterior
            Navigator.of(context).pop(true);
          } else {
            Fluttertoast.showToast(
              msg: 'Error al insertar estudiante',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        } catch (error) {
          Fluttertoast.showToast(
            msg: 'Error al conectar con el servidor',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Por favor, ingresa un email o carnet válido',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Por favor, completa todos los campos',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Students'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Escribe tu nombre',
              ),
            ),
            TextField(
              controller: _apellidoController,
              decoration: const InputDecoration(
                labelText: 'Apellido',
                hintText: 'Escribe tu apellido',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Escribe tu email',
              ),
            ),
            TextField(
              controller: _carnetController,
              decoration: const InputDecoration(
                labelText: 'Carnet',
                hintText: 'Escribe tu carnet',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarEstudiante,
              child: const Text('Insertar'),
            ),
          ],
        ),
      ),
    );
  }
}
