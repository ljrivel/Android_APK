import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                Icons.bookmark_add,
              ),
              title: const Text('Insertar'),
              onTap: () {
                // Acción al seleccionar Inicio
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.bookmark_remove,
              ),
              title: const Text('Eliminar'),
              onTap: () {
                // Acción al seleccionar Configuración
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Modificar'),
              onTap: () {
                // Acción al seleccionar Configuración
                Navigator.pop(context);
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
                label: Text('id'),
                numeric: true,
              ),
              DataColumn(
                label: Text('Nombre'),
                numeric: false,
              ),
            ],
            rows: CoursesData.map((student) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(student['id'] ?? '')),
                  DataCell(Text(student['nombre'] ?? '')),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
