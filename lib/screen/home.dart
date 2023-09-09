import 'package:flutter/material.dart';
import 'package:flutter_v1/screen/students/homeStudents.dart';
import 'package:flutter_v1/screen/Courses/homeCourses.dart';
import 'package:flutter_v1/screen/Registers/homeRegisters.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
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
                Icons.assignment_ind,
              ),
              title: const Text('Students'),
              onTap: () {
                // Acción al seleccionar Inicio
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
            // Agrega más opciones aquí
          ],
        ),
      ),
    );
  }
}
