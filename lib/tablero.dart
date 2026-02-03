import 'package:flutter/material.dart';
import 'cards.dart';

class Tablero{
  List<Cards> cartas = []; 
  List<int> cartasVolteadas =[];
  int intentos = 0;
  Tablero(){
    inicializarTablero();

  }



void inicializarTablero(){
  cartas.clear(); 
  cartasVolteadas.clear(); 
  intentos = 0;
  for(int i =1;i<=18;i++){
    cartas.add(Cards(valor: i)); 
    cartas.add(Cards(valor: i)); 
  }
  cartas.shuffle();
}

// para que se puede voltear solo una
bool puedeVoltear(int index){
  return !cartas[index].volteada &&
  !cartas[index].encontrada &&
  cartasVolteadas.length<2;
}
void voltearCarta(int index){
  if(!puedeVoltear(index)) return; 
  cartas[index].volteada = true;
  cartasVolteadas.add(index);
  if(cartasVolteadas.length==2){
    intentos ++;
  }
  

}
}