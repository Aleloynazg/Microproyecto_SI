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
  Tablero tablero = Tablero();
  int? mejorPuntaje;

  void _verificarPareja() {
    int i1 = tablero.cartasVolteadas[0];
    int i2 = tablero.cartasVolteadas[1];

    if (tablero.cartas[i1].valor == tablero.cartas[i2].valor) {
      tablero.cartas[i1].encontrada = true;
      tablero.cartas[i2].encontrada = true;
      _revisarSiGano();
    } else {
      tablero.cartas[i1].volteada = false;
      tablero.cartas[i2].volteada = false;
    }
    tablero.cartasVolteadas.clear();
  }

  void _revisarSiGano() {
    bool gano = tablero.cartas.every((carta) => carta.encontrada);
    
    if (gano) {
      setState(() {
        if (mejorPuntaje == null || tablero.intentos < mejorPuntaje!) {
          mejorPuntaje = tablero.intentos;
        }
      });
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text("¡FELICITACIONES 🎉!", textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.emoji_events, color: Colors.amber, size:80),
                const SizedBox(height:20),
                Text(
                  "Lo lograste en ${tablero.intentos} intentos.",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                if (tablero.intentos == mejorPuntaje)
                  const Padding(
                    padding: EdgeInsets.only(top:10),
                    child: Text(
                      "¡Es un nuevo récord!🏆",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  setState((){
                    tablero = Tablero();
                  });
                },
                child: const Text("Jugar de nuevo", style: TextStyle(fontSize:18)),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("¡Encuentra el PAR!"), 
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 25), 
            onPressed: () {
              setState(() {
                tablero = Tablero();
              });
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'Récord: ${mejorPuntaje ?? "-"} | Intentos: ${tablero.intentos}', 
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 1, 30, 10),
        child: Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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