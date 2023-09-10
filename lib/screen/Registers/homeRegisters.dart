// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:RivelAPK/screen/Registers/DeleteRegisters.dart';
import 'package:RivelAPK/screen/Registers/EditRegisters.dart';
import 'package:RivelAPK/screen/Registers/InsertRegisters.dart';
import 'package:http/http.dart' as http;

class HomeScreenRegisters extends StatefulWidget {
  const HomeScreenRegisters({super.key});

  @override
  State<HomeScreenRegisters> createState() => _HomeScreenRegistersState();
}

//Pagina principal de matricula, muestra todas las matriculas registrados
class _HomeScreenRegistersState extends State<HomeScreenRegisters> {
  List<Map<String, dynamic>> RegistersData =
      []; // Almacena los datos de los estudiantes
  String errorMessage = ''; // Almacena el mensaje de error del API

  //inicializacion de los datos
  @override
  void initState() {
    super.initState();
    // Llama a la función para cargar los datos de la API al iniciar la página
    fetchRegistersData();
  }

  //solicita los datos de la api
  Future<void> fetchRegistersData() async {
    const apiUrl =
        'https://api-android-rivel.onrender.com/getRegisters'; // Reemplaza con la URL de tu API
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        RegistersData = data.cast<Map<String, dynamic>>();
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
      appBar: AppBar(title: const Text('Registers'), centerTitle: true),
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
                Icons.queue,
              ),
              title: const Text('Insertar'),
              onTap: () async {
                // Acción al seleccionar Configuración
                Navigator.pop(context);
                final result =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InsertRegisters(),
                ));

                // Verificar si se debe recargar los datos
                if (result == true) {
                  await fetchRegistersData(); // Recargar los datos desde el API
                }
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.remove,
              ),
              title: const Text('Eliminar'),
              onTap: () async {
                // Acción al seleccionar Configuración
                Navigator.pop(context);
                final result =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DeleteRegisters(),
                ));

                // Verificar si se debe recargar los datos
                if (result == true) {
                  await fetchRegistersData(); // Recargar los datos desde el API
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Modificar'),
              onTap: () async {
                // Acción al seleccionar Configuración
                Navigator.pop(context);
                final result =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const EditRegisters(),
                ));

                // Verificar si se debe recargar los datos
                if (result == true) {
                  await fetchRegistersData(); // Recargar los datos desde el API
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
                label: Text('ID'),
                numeric: false,
              ),
              DataColumn(
                label: Text('Nombre'),
                numeric: false,
              ),
              DataColumn(
                label: Text('Curso'),
                numeric: false,
              ),
            ],
            rows: RegistersData.map((registers) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(registers['id_curso_matriculado'].toString())),
                  DataCell(Text(registers['nombre_completo_estudiante'] ?? '')),
                  DataCell(Text(registers['nombre_curso'] ?? '')),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
