import 'package:flutter/material.dart';
import 'package:microproyecto_si/tablero.dart';
import 'package:microproyecto_si/cardsWidgets.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  // Quite el final para poder reiniciarlo 
  Tablero tablero = Tablero();

  // 2. La función para verificar parejas DEBE estar aquí adentro
  void _verificarPareja() {
    int i1 = tablero.cartasVolteadas[0];
    int i2 = tablero.cartasVolteadas[1];

    if (tablero.cartas[i1].valor == tablero.cartas[i2].valor) {
      tablero.cartas[i1].encontrada = true;
      tablero.cartas[i2].encontrada = true;
    } else {
      tablero.cartas[i1].volteada = false;
      tablero.cartas[i2].volteada = false;
    }
    tablero.cartasVolteadas.clear();
  }

  // 3. El método build es el que dibuja todo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memoria 6x6"), 
        centerTitle: true,
        actions:[
          IconButton(
            icon: const Icon(Icons.refresh, size: 25), 
            onPressed:() {setState(() {
              {tablero=Tablero();}
            });},),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
                child: Text(
              'Intentos: ${tablero.intentos}', 
              style: const TextStyle(fontSize: 17)
            ),
          ),
            ),
            ],
            ),
  
            body: Container(
              
            margin: const EdgeInsets.fromLTRB(30,1,30,10),
              
               child: Center(
                
                child: AspectRatio(aspectRatio: 1,
                
                child: GridView.builder(
              
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                
                
                crossAxisCount: 6,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: tablero.cartas.length,
              itemBuilder: (context, index) {
                return CartaWidget(
                  carta: tablero.cartas[index],
                  onTap: () {
                    // Aquí es donde controlamos el flujo
                    if (tablero.puedeVoltear(index)) {
                      setState(() {
                        tablero.voltearCarta(index);
                      });

                      if (tablero.cartasVolteadas.length == 2) {
                        Future.delayed(const Duration(milliseconds: 600), () {
                          if (mounted) {
                            setState(() {
                              _verificarPareja();
                            });
                          }
                        });
                      }
                    }
                  },
                );
              },
                ),
            ),
               ),
            ),
    );
  }
 

  }
