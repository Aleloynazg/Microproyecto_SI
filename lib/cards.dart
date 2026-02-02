import 'package:flutter/material.dart';

class Cards {
  final int valor;
  bool volteada; 
  bool encontrada;

  
  Cards({required this.valor, 
  this.volteada = false, 
  this.encontrada = false});
}