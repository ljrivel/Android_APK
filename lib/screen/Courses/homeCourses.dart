// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:RivelAPK/screen/Courses/DeleteCourses.dart';
import 'package:RivelAPK/screen/Courses/EditCourses.dart';
import 'package:RivelAPK/screen/Courses/InsertCourses.dart';
import 'package:http/http.dart' as http;

//Pagina principal de cursos, muestra todos los cursos registrados
class HomeScreenCourses extends StatefulWidget {
  const HomeScreenCourses({super.key});

  @override
  State<HomeScreenCourses> createState() => _HomeScreenCoursesState();
}

class _HomeScreenCoursesState extends State<HomeScreenCourses> {
  List<Map<String, dynamic>> CoursesData =
      []; // Almacena los datos de los estudiantes
  String errorMessage = ''; // Almacena el mensaje de error del API

  //inicializacion de los datos
  @override
  void initState() {
    super.initState();
    // Llama a la función para cargar los datos de la API al iniciar la página
    fetchCoursesData();
  }

  //solicita los datos de la api
  Future<void> fetchCoursesData() async {
    const apiUrl =
        'https://api-android-rivel.onrender.com/getCourses'; // Reemplaza con la URL de tu API
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        CoursesData = data.cast<Map<String, dynamic>>();
      });
    } else {
      final json = jsonDecode(response.body);
      if (json['error'] == 'La tabla curso está vacía.') {
        setState(() {
          errorMessage = 'No hay cursos registrados.';
        });
      } else {
        throw Exception('Error al cargar los datos de la API');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses'), centerTitle: true),
      endDrawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
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
                Icons.bookmark_add,
              ),
              title: const Text('Insertar'),
              onTap: () async {
                Navigator.pop(context);
                final result =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InsertCourses(),
                ));

                // Verificar si se debe recargar los datos
                if (result == true) {
                  await fetchCoursesData(); // Recargar los datos desde el API
                }
                // Acción al seleccionar Inicio
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.bookmark_remove,
              ),
              title: const Text('Eliminar'),
              onTap: () async {
                Navigator.pop(context);
                final result =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DeleteCourses(),
                ));

                // Verificar si se debe recargar los datos
                if (result == true) {
                  await fetchCoursesData(); // Recargar los datos desde el API
                }
                // Acción al seleccionar Inicio
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Modificar'),
              onTap: () async {
                Navigator.pop(context);
                final result =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EditCourses(),
                ));

                // Verificar si se debe recargar los datos
                if (result == true) {
                  await fetchCoursesData(); // Recargar los datos desde el API
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
                label: Text('Codigo'),
                numeric: false,
              ),
              DataColumn(
                label: Text('Nombre'),
                numeric: false,
              ),
            ],
            rows: CoursesData.map((courses) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(courses['codigo'].toString())),
                  DataCell(Text(courses['nombre'] ?? '')),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
