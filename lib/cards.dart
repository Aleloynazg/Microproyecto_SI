import 'package:flutter/material.dart';

class Cards {
  final int valor;
  final IconData icono;
  bool volteada; 
  bool encontrada;

  
  Cards({required this.valor, 
  required this.icono,
  this.volteada = false, 
  this.encontrada = false});
}