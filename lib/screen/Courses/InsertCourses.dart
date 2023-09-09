// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class InsertCourses extends StatefulWidget {
  const InsertCourses({Key? key}) : super(key: key);
  @override
  State<InsertCourses> createState() => _InsertCourses();
}

class _InsertCourses extends State<InsertCourses> {
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  Future<void> _guardarCurso() async {
    final nombre = _nombreController.text;
    final codigo = _codigoController.text;
    final descripcion = _descripcionController.text;

    if (nombre.isNotEmpty && codigo.isNotEmpty && descripcion.isNotEmpty) {
      final curso = {
        'nombre': nombre,
        'codigo': codigo,
        'descripcion': descripcion
      };

      try {
        final response = await http.post(
          Uri.parse(
              'https://api-android-rivel.onrender.com/addCourse'), // Reemplaza con la URL de tu API
          body: curso,
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
          // Si la solicitud no es exitosa
          Fluttertoast.showToast(
            msg: 'Error al insertar curso',
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
      appBar: AppBar(title: const Text('Add Curso'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Escribe el nombre del curso',
              ),
            ),
            TextField(
              controller: _codigoController,
              decoration: const InputDecoration(
                labelText: 'Codigo',
                hintText: 'Escribe el codigo del curso',
              ),
            ),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripcion',
                hintText: 'Describe el curso',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarCurso,
              child: const Text('Insertar Curso'),
            ),
          ],
        ),
      ),
    );
  }
}
