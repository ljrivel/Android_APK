// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EditRegisters extends StatefulWidget {
  const EditRegisters({super.key});

  @override
  _EditRegistersState createState() => _EditRegistersState();
}

//Editar pide el id y despues despliega la informacion
class _EditRegistersState extends State<EditRegisters> {
  // Controladores para obtener los datos de los campos de texto
  TextEditingController idController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  late List<dynamic> registerData;
  String errorMessage = '';
  bool isDataLoaded = false;

  bool isNumberValid(String number) {
    // Verificar si el valor es un número
    return int.tryParse(number) != null;
  }

  bool isDateValid(String date) {
    try {
      // Intenta analizar la fecha ingresada
      DateFormat('yyyy-MM-dd').parse(date);
      return true;
    } catch (e) {
      return false;
    }
  }

  void fetchregisterData() async {
    final id = idController.text;
    final estudiante = {
      'id': id,
    };
    const apiUrl =
        'https://api-android-rivel.onrender.com/getRegisterByID'; // Reemplaza con la URL de tu API

    if (id.isNotEmpty && isNumberValid(id)) {
      try {
        final response = await http.post(Uri.parse(apiUrl), body: estudiante);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          setState(() {
            registerData = data;
            isDataLoaded = true;
            fechaController.text = registerData[0]['fecha_matricula'] ?? '';
          });
        } else {
          Fluttertoast.showToast(
            msg: 'Error al encontrar el id',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } catch (error) {
        Fluttertoast.showToast(
          msg: 'Error al con el API de id',
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
    } else {
      Fluttertoast.showToast(
        msg: 'Digite un id valido',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void updateregisterData() async {
    // Obtén los datos actualizados desde los controladores fechaController y apellidoController
    final updatedDate = fechaController.text;

    if (!isDateValid(updatedDate)) {
      Fluttertoast.showToast(
        msg: 'Ingrese una fecha válida en el formato yyyy-MM-dd',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    final updatedData = {'fecha': updatedDate, 'id': idController.text};

    const apiUrl =
        'https://api-android-rivel.onrender.com/editRegister'; // Reemplaza con la URL para actualizar datos

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
              controller: idController,
              decoration: const InputDecoration(labelText: 'Número de id'),
            ),
            ElevatedButton(
              onPressed: () {
                fetchregisterData();
              },
              child: const Text('Obtener Datos'),
            ),
            const SizedBox(height: 20),
            if (isDataLoaded)
              Column(
                children: [
                  TextField(
                    controller: fechaController,
                    decoration: const InputDecoration(labelText: 'fecha'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      updateregisterData();
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
