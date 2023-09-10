// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class InsertRegisters extends StatefulWidget {
  const InsertRegisters({Key? key}) : super(key: key);
  @override
  State<InsertRegisters> createState() => _InsertRegisters();
}

//Pantalla para insertar estudiantes
class _InsertRegisters extends State<InsertRegisters> {
  // Controladores para obtener los datos de los campos de texto
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _carnetController = TextEditingController();

  Future<void> _guardarregistro() async {
    final codigo = _codigoController.text;
    final carnet = _carnetController.text;

    if (codigo.isNotEmpty && carnet.isNotEmpty) {
      final registro = {
        'codigo': codigo,
        'carnet': carnet,
      };

      try {
        final response = await http.post(
          Uri.parse(
              'https://api-android-rivel.onrender.com/addRegister'), // Reemplaza con la URL de tu API
          body: registro,
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data['error'] ==
              'El estudiante ya está matriculado en el curso.') {
            Fluttertoast.showToast(
              msg: 'El estudiante ya esta matriculado en este curso',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
          } else {
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
          }
        } else {
          Fluttertoast.showToast(
            msg: 'Error al insertar registro',
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
      appBar: AppBar(title: const Text('Add Students'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _codigoController,
              decoration: const InputDecoration(
                labelText: 'Codigo',
                hintText: 'Escribe el codigo del curso',
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
              onPressed: _guardarregistro,
              child: const Text('Insertar'),
            ),
          ],
        ),
      ),
    );
  }
}
