import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const double alturaBotao = 80.0;
const Color fundo = Color(0xFF1E164B);
const Color selecionado = Color.fromARGB(255, 45, 11, 237);

enum Animal { gato, cachorro }

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Animal? animalSelecionado;
  int idade = 1;
  double peso = 4.0;

  double calcularIdadeHumanaEquivalente() {
    if (animalSelecionado == null) return 0.0;
    double anos = idade.toDouble();
    if (animalSelecionado == Animal.cachorro) {
      if (anos <= 0) {
        return 0.0;
      } else {
        return 16 * log(anos);
      }
    } else {
      if (anos <= 2) {
        if (anos == 0) return 0;
        if (anos == 1) return 15;
        return 24;
      } else {
        return 4.1364 * anos + 15;
      }
    }
  }

  String tipoAnimalTexto() {
    if (animalSelecionado == Animal.cachorro) {
      return 'Cachorro';
    } else if (animalSelecionado == Animal.gato) {
      return 'Gato';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double idadeHumana = calcularIdadeHumanaEquivalente();

    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Idade Fisiológica de Pet')),
        body: Column(
          children: [
            // Seção de tipo de animal
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          animalSelecionado = Animal.cachorro;
                        });
                      },
                      child: Caixa(
                        cor: animalSelecionado == Animal.cachorro
                            ? selecionado
                            : fundo,
                        filho: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.pets, size: 80, color: Colors.white),
                            SizedBox(height: 15),
                            Text(
                              'CACHORRO',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          animalSelecionado = Animal.gato;
                        });
                      },
                      child: Caixa(
                        cor: animalSelecionado == Animal.gato
                            ? selecionado
                            : fundo,
                        filho: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.pets, size: 80, color: Colors.white),
                            SizedBox(height: 15),
                            Text(
                              'GATO',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Seção idade
            Expanded(
              child: Caixa(
                cor: fundo,
                filho: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'IDADE (anos)',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    Text(
                      '$idade',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          heroTag: 'menosIdade',
                          mini: true,
                          backgroundColor: Colors.blueGrey,
                          onPressed: () {
                            setState(() {
                              if (idade > 0) idade--;
                            });
                          },
                          child: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 10),
                        FloatingActionButton(
                          heroTag: 'maisIdade',
                          mini: true,
                          backgroundColor: Colors.blueGrey,
                          onPressed: () {
                            setState(() {
                              idade++;
                            });
                          },
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Seção peso
            Expanded(
              child: Caixa(
                cor: fundo,
                filho: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'PESO (kg)',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    Text(
                      peso.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Slider(
                      value: peso,
                      min: 0.5,
                      max: 100.0,
                      divisions: 200,
                      label: peso.toStringAsFixed(1),
                      onChanged: (novo) {
                        setState(() {
                          peso = novo;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Resultado
            Expanded(
              child: Caixa(
                cor: fundo,
                filho: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'IDADE HUMANA EQUIVALENTE',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    Text(
                      idadeHumana.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      tipoAnimalTexto(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Caixa extends StatelessWidget {
  final Color cor;
  final Widget? filho;
  const Caixa({required this.cor, this.filho, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: cor,
      ),
      child: filho,
    );
  }
}
