// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EditStudents extends StatefulWidget {
  const EditStudents({super.key});

  @override
  _EditStudentsState createState() => _EditStudentsState();
}

//Editar pide el carnet y despues despliega la informacion
class _EditStudentsState extends State<EditStudents> {
  // Controladores para obtener los datos de los campos de texto
  TextEditingController carnetController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  late List<dynamic> studentData;
  String errorMessage = '';
  bool isDataLoaded = false;

  //Solicita los datos del estudiante
  void fetchStudentData() async {
    final carnet = carnetController.text;
    final estudiante = {
      'carnet': carnet,
    };
    const apiUrl =
        'https://api-android-rivel.onrender.com/getStudentsbyCarnet'; // Reemplaza con la URL de tu API

    try {
      final response = await http.post(Uri.parse(apiUrl), body: estudiante);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          studentData = data;
          isDataLoaded = true;
          emailController.text = studentData[0]['email'] ?? '';
          nombreController.text = studentData[0]['nombre'] ?? '';
          apellidoController.text = studentData[0]['apellido'] ?? '';
        });
      } else {
        Fluttertoast.showToast(
          msg: 'Error al encontrar el carnet',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Error al con el API de carnet',
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

  void updateStudentData() async {
    // Obtén los datos actualizados desde los controladores nombreController y apellidoController
    final updatedData = {
      'nombre': nombreController.text,
      'apellido': apellidoController.text,
      'email': emailController.text,
      'carnet': carnetController.text
    };

    const apiUrl =
        'https://api-android-rivel.onrender.com/editStudent'; // Reemplaza con la URL para actualizar datos

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
              controller: carnetController,
              decoration: const InputDecoration(labelText: 'Número de Carnet'),
            ),
            ElevatedButton(
              onPressed: () {
                fetchStudentData();
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
                    controller: apellidoController,
                    decoration: const InputDecoration(labelText: 'Apellido'),
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      updateStudentData();
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
