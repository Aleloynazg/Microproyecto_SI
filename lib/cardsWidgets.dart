import 'package:flutter/material.dart';
import 'cards.dart';

class CartaWidget extends StatefulWidget {
  final Cards carta; 
  final VoidCallback onTap; 
  
  const CartaWidget({
    super.key, 
    required this.carta, 
    required this.onTap,

  });
  @override
  State<CartaWidget> createState()=>_CartaWidgetState();
}
class _CartaWidgetState extends State<CartaWidget>{
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        widget.onTap();},
        child: Container(
        margin: const EdgeInsets.all(1), 
        decoration: BoxDecoration(
          color: estadoColor(), 
          borderRadius: BorderRadius.circular(5)
 
        ),
      child:Center(
    child: contenidoCarta(),
  )
)
      );

    

  }
  Widget contenidoCarta(){
    if(widget.carta.volteada|| widget.carta.encontrada){
      return Text(
        widget.carta.valor.toString(), 
        style: const TextStyle(
          fontSize: 20,
        ),
      );
    
    }
    return const Text('');

  }
Color estadoColor(){
  if(widget.carta.encontrada){
    return Colors.green; //Cambiarlo a verde cuando ya esten en pareja
  } else if (widget.carta.volteada){
    return Colors.white;

  }else{
  return Colors.purple;
    }
  }
}
