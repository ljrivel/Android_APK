// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class DeleteCourses extends StatefulWidget {
  const DeleteCourses({Key? key}) : super(key: key);
  @override
  State<DeleteCourses> createState() => _DeleteCourses();
}

class _DeleteCourses extends State<DeleteCourses> {
  final TextEditingController _codigoController = TextEditingController();

  Future<void> _borrarCursos() async {
    final codigo = _codigoController.text;

    if (codigo.isNotEmpty) {
      final curso = {
        'codigo': codigo,
      };

      try {
        final response = await http.post(
          Uri.parse(
              'https://api-android-rivel.onrender.com/deleteCourse'), // Reemplaza con la URL de tu API
          body: curso,
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
          // Si la solicitud no es exitosa
          Fluttertoast.showToast(
            msg: 'Error al eliminar curso',
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
      appBar: AppBar(title: const Text('Delete Courses'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _codigoController,
              decoration: const InputDecoration(
                labelText: 'Codigo',
                hintText: 'Escribe tu codigo',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _borrarCursos,
              child: const Text('Eliminar'),
            ),
          ],
        ),
      ),
    );
  }
}
