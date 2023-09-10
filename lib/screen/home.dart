import 'package:flutter/material.dart';
import 'package:RivelAPK/screen/students/homeStudents.dart';
import 'package:RivelAPK/screen/Courses/homeCourses.dart';
import 'package:RivelAPK/screen/Registers/homeRegisters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//Pagina principal

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            //Barra de la derecha
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
            //Botones de la barra
            ListTile(
              leading: const Icon(
                Icons.assignment_ind,
              ),
              title: const Text('Students'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreenStudents()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.library_books,
              ),
              title: const Text('Courses'),
              onTap: () {
                // Acción al seleccionar Configuración
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreenCourses()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.grading,
              ),
              title: const Text('Registers'),
              onTap: () {
                // Acción al seleccionar Configuración
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreenRegisters()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Aplicación hecha por Luis Rivel',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24, // Tamaño de fuente grande
                fontWeight: FontWeight.bold, // Texto en negrita
                color: Colors.blue, // Color de texto personalizado
              ),
            ),
            Text(
              'para proyecto de programación',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, // Tamaño de fuente más grande
                fontStyle: FontStyle.italic, // Texto en cursiva
                color: Colors.green, // Otro color de texto personalizado
              ),
            ),
            Text(
              'hecha en Flutter',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18, // Tamaño de fuente grande
                color: Colors.red, // Otro color de texto personalizado
              ),
            ),
          ],
        ),
      ),
    );
  }
}
