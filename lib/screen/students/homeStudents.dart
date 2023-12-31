// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:RivelAPK/screen/students/InsertStudents.dart';
import 'package:RivelAPK/screen/students/DeleteStudents.dart';
import 'package:RivelAPK/screen/students/EditStudents.dart';
import 'package:http/http.dart' as http;

class HomeScreenStudents extends StatefulWidget {
  const HomeScreenStudents({super.key});

  @override
  State<HomeScreenStudents> createState() => _HomeScreenStudentsState();
}

//Pagina principal de estudiantes, muestra todos los estudiantes registrados
class _HomeScreenStudentsState extends State<HomeScreenStudents> {
  List<Map<String, dynamic>> studentsData =
      []; // Almacena los datos de los estudiantes
  String errorMessage = ''; // Almacena el mensaje de error del API

  //inicializacion de los datos
  @override
  void initState() {
    super.initState();
    // Llama a la función para cargar los datos de la API al iniciar la página
    fetchStudentsData();
  }

  //solicita los datos de la api
  Future<void> fetchStudentsData() async {
    const apiUrl =
        'https://api-android-rivel.onrender.com/getStudents'; // Reemplaza con la URL de tu API
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        studentsData = data.cast<Map<String, dynamic>>();
      });
    } else {
      final json = jsonDecode(response.body);
      if (json['error'] == 'La tabla estudiante está vacía.') {
        setState(() {
          errorMessage = 'No hay estudiantes registrados.';
        });
      } else {
        throw Exception('Error al cargar los datos de la API');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Students'), centerTitle: true),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Opciones',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person_add_alt_1,
              ),
              title: const Text('Insertar'),
              onTap: () async {
                Navigator.pop(context);
                final result =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InsertStudents(),
                ));

                // Verificar si se debe recargar los datos
                if (result == true) {
                  await fetchStudentsData(); // Recargar los datos desde el API
                }
                // Acción al seleccionar Inicio
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person_remove,
              ),
              title: const Text('Eliminar'),
              onTap: () async {
                // Acción al seleccionar Configuración
                Navigator.pop(context);
                final result =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DeleteStudents(),
                ));

                // Verificar si se debe recargar los datos
                if (result == true) {
                  await fetchStudentsData(); // Recargar los datos desde el API
                }
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.manage_accounts,
              ),
              title: const Text('Modificar'),
              onTap: () async {
                // Acción al seleccionar Configuración
                Navigator.pop(context);
                final result =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EditStudents(),
                ));

                // Verificar si se debe recargar los datos
                if (result == true) {
                  await fetchStudentsData(); // Recargar los datos desde el API
                }
              },
            ),
          ],
        ),
      ),
      body: Visibility(
        visible: errorMessage.isEmpty,
        replacement:
            Text(errorMessage), // Muestra la tabla si errorMessage está vacío
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Nombre'),
                numeric: false,
              ),
              DataColumn(
                label: Text('Apellido'),
                numeric: false,
              ),
              DataColumn(
                label: Text('Carnet'),
                numeric: false,
              ),
            ],
            rows: studentsData.map((student) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(student['nombre'] ?? '')),
                  DataCell(Text(student['apellido'] ?? '')),
                  DataCell(Text(student['carnet'] ?? '')),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
