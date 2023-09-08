import 'package:flutter/material.dart';
import 'dart:convert';

class InsertStudents extends StatefulWidget {
  const InsertStudents({Key? key}) : super(key: key);
  @override
  State<InsertStudents> createState() => _InsertStudents();
}

class _InsertStudents extends State<InsertStudents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Students'), centerTitle: true),
    );
  }
}
