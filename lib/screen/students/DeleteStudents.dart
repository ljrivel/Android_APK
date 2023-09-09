import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class DeleteStudents extends StatefulWidget {
  const DeleteStudents({Key? key}) : super(key: key);
  @override
  State<DeleteStudents> createState() => _DeleteStudents();
}

class _DeleteStudents extends State<DeleteStudents> {
  final TextEditingController _carnetController = TextEditingController();

  bool isNumberValid(String number) {
    // Verificar si el valor es un número
    return int.tryParse(number) != null;
  }

  Future<void> _guardarEstudiante() async {
    final carnet = _carnetController.text;

    if (carnet.isNotEmpty) {
      if (isNumberValid(carnet)) {
        final estudiante = {
          'carnet': carnet,
        };

        try {
          final response = await http.post(
            Uri.parse(
                'https://api-android-rivel.onrender.com/deleteStudent'), // Reemplaza con la URL de tu API
            body: estudiante,
          );

          if (response.statusCode == 200) {
            // Si la solicitud es exitosa
            Fluttertoast.showToast(
              msg: 'Se ha eliminado correctamente',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );

            // Cerrar la pantalla actual y volver a la anterior
            Navigator.of(context).pop(true);
          } else {
            print(response); // Si la solicitud no es exitosa
            Fluttertoast.showToast(
              msg: 'Error al eliminar estudiante',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          }
        } catch (error) {
          print('Error: $error');
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
          msg: 'Por favor, ingresa un  carnet válido',
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
      appBar: AppBar(title: const Text('Delete Students'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
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
              child: const Text('Eliminar'),
            ),
          ],
        ),
      ),
    );
  }
}
