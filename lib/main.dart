import 'dart:io';

import 'package:flutter/material.dart';
import 'package:microproyecto_si/tablero.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Juego de Memoeria',
      theme: ThemeData.light()
      home: const BoardMemory(),
    );
  }
}

class BoardMemory extends StatefulWidget {
  const BoardMemory({super.key});

  @override
  State<BoardMemory> createState() => _BoardMemoryState();
}

class _BoardMemoryState extends State<BoardMemory> {
  final Tablero tablero = Tablero();
  
  @override
  Widget build(BuildContext context) {
       return Scaffold(
      appBar: AppBar(
        title: const Text("Juego Memoria"),
        centerTitle: true,
        ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10), 
            child: Text(
              // Aqui falta poner como es que se pone el cuadradito de intentos 
              'Intentos' , 
              style: const TextStyle(fontSize: 20),
            ),
          ),
      Expanded(
        child:GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)

      )
        ];
        )
}
}
