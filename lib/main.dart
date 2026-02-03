import 'dart:io';

import 'package:flutter/material.dart';
import 'package:microproyecto_si/tablero.dart';
import 'package:microproyecto_si/cardsWidgets.dart';


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
      theme: ThemeData.light(),
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

  //Funcion para manejar el click 
  void _manejarVolteo(int index){
    if (tablero.puedeVoltear(index)){
      setState((){
        tablero.voltearCarta(index);
      });

      if (tablero.cartasVolteadas.length == 2){
        Future.delayed(const Duration (milliseconds:600),(){
          if (mounted){
            setState((){
              _verificarPareja();
            });
          }
        });
      }
    }
  }

  void _verificarPareja(){
    int i1= tablero.cartasVolteadas[0];
    int i2 = tablero.cartasVolteadas[1];

    if (tablero.cartas[i1].valor == tablero.cartas [i2].valor){
      tablero.cartas[i1].encontrada = true;
      tablero.cartas[i2].encontrada = true;
      } else{
        tablero.cartas[i1].encontrada = false;
        tablero.cartas[i2].encontrada = false;
      }
      tablero.cartasVolteadas.clear();
  }
  
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
            padding: const EdgeInsets.symmetric(vertical: 20), 
            child: Text(
              // Aqui falta poner como es que se pone el cuadradito de intentos 
              'Intentos' , 
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
      Expanded(
  child: GridView.builder(
    padding: const EdgeInsets.all(10),
    // Configuración 6x6
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 6, // 6 columnas
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
    ),
    itemCount: tablero.cartas.length,
    itemBuilder: (context, index) {
      return CartaWidget(
        carta: tablero.cartas[index],
        onTap: () => _manejarVolteo(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
