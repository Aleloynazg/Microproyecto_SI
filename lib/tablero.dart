import 'package:flutter/material.dart';
import 'cards.dart';

class Tablero{
  List<Cards> cartas = []; 
  List<int> cartasVolteadas =[];
  int intentos = 0;
  Tablero(){
    inicializarTablero();

  }

final List<IconData> iconosDisponibles=[
 Icons.star, Icons.favorite, Icons.icecream, Icons.pets, Icons.ice_skating, Icons.rocket,
  Icons.emoji_emotions, Icons.alarm, Icons.lightbulb, Icons.local_pizza, Icons.music_note, 
  Icons.fire_truck_outlined, Icons.cake, Icons.umbrella, Icons.diamond, Icons.sunny, Icons.money,
  Icons.videocam, Icons.bug_report, Icons.forest, Icons.cabin, Icons.family_restroom, Icons.airplanemode_active,
  Icons.restaurant, Icons.handshake, Icons.sports_basketball


];

void inicializarTablero(){
  cartas.clear(); 
  cartasVolteadas.clear(); 
  intentos = 0;
  iconosDisponibles.shuffle();
  for(int i =1;i<=18;i++){
    IconData escogido = iconosDisponibles[i];
    cartas.add(Cards(valor: i,icono: escogido)); 
    cartas.add(Cards(valor: i, icono: escogido)); 
  }
  cartas.shuffle();
}

// para que se puede voltear solo una
bool puedeVoltear(int index){
  return !cartas[index].volteada &&
  !cartas[index].encontrada &&
  cartasVolteadas.length < 2;
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