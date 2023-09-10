// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class DeleteRegisters extends StatefulWidget {
  const DeleteRegisters({Key? key}) : super(key: key);
  @override
  State<DeleteRegisters> createState() => _DeleteRegisters();
}

//Pantalla para eliminar registros
class _DeleteRegisters extends State<DeleteRegisters> {
  // Controladores para obtener los datos de los campos de texto
  final TextEditingController _idController = TextEditingController();

  Future<void> _borrarRegistros() async {
    final id = _idController.text;

    if (id.isNotEmpty) {
      final curso = {
        'id': id,
      };

      try {
        final response = await http.post(
          Uri.parse(
              'https://api-android-rivel.onrender.com/deleteRegister'), // Reemplaza con la URL de tu API
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
      appBar: AppBar(title: const Text('Delete Registers'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'id',
                hintText: 'Escribe tu id',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _borrarRegistros,
              child: const Text('Eliminar'),
            ),
          ],
        ),
      ),
    );
  }
}
