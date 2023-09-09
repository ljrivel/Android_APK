// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EditCourses extends StatefulWidget {
  const EditCourses({super.key});

  @override
  _EditCoursesState createState() => _EditCoursesState();
}

class _EditCoursesState extends State<EditCourses> {
  TextEditingController codigoController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  late List<dynamic> courseData;
  String errorMessage = '';
  bool isDataLoaded = false;

  void fetchcourseData() async {
    final codigo = codigoController.text;
    final curso = {
      'codigo': codigo,
    };
    const apiUrl =
        'https://api-android-rivel.onrender.com/getCoursesByCode'; // Reemplaza con la URL de tu API

    try {
      final response = await http.post(Uri.parse(apiUrl), body: curso);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          courseData = data;
          isDataLoaded = true;
          descripcionController.text = courseData[0]['descripcion'] ?? '';
          nombreController.text = courseData[0]['nombre'] ?? '';
        });
      } else {
        Fluttertoast.showToast(
          msg: 'Error al encontrar el curso',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Error al con el API de curso',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      setState(() {
        errorMessage = 'Error con el API: $error';
        isDataLoaded = false;
      });
    }
  }

  void updatecourseData() async {
    // Obtén los datos actualizados desde los controladores nombreController y apellidoController
    final updatedData = {
      'nombre': nombreController.text,
      'descripcion': descripcionController.text,
      'codigo': codigoController.text
    };

    const apiUrl =
        'https://api-android-rivel.onrender.com/editCourse'; // Reemplaza con la URL para actualizar datos

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: updatedData,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Se ha actualizado correctamente',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        // Cerrar la pantalla actual y volver a la anterior
        Navigator.of(context).pop(true);
      } else {
        Fluttertoast.showToast(
          msg: 'Error al actualizar los datos',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Error al conectar con el api',
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
      appBar: AppBar(title: const Text('Modificar Datos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: codigoController,
              decoration: const InputDecoration(labelText: 'Codigo del Curso'),
            ),
            ElevatedButton(
              onPressed: () {
                fetchcourseData();
              },
              child: const Text('Obtener Datos'),
            ),
            const SizedBox(height: 20),
            if (isDataLoaded)
              Column(
                children: [
                  TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  TextField(
                    controller: descripcionController,
                    decoration:
                        const InputDecoration(labelText: 'Descripcion123'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      updatecourseData();
                    },
                    child: const Text('Guardar Cambios'),
                  ),
                ],
              ),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
