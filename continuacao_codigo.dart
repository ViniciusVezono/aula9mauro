import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const double alturaBotao = 80.0;
const Color fundo = Color(0xFF1E164B);
const Color selecionado = Color.fromARGB(255, 45, 11, 237);

enum Genero { masculino, feminino }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double altura = 170;
  int peso = 65;
  Genero? generoSelecionado; // <-- variável de estado para o gênero

  double calcularIMC() {
    double alturaMetros = altura / 100;
    return peso / (alturaMetros * alturaMetros);
  }

  @override
  Widget build(BuildContext context) {
    double imc = calcularIMC();

    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Calculadora IMC')),
        body: Column(
          children: [
            // Seção de gênero
            Expanded(
              child: Row(
                children: [
                  // Masculino
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          generoSelecionado = Genero.masculino;
                        });
                      },
                      child: Caixa(
                        cor: generoSelecionado == Genero.masculino
                            ? selecionado
                            : fundo,
                        filho: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.male, size: 80, color: Colors.white),
                            SizedBox(height: 15.0),
                            Text(
                              'MASC',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Feminino
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          generoSelecionado = Genero.feminino;
                        });
                      },
                      child: Caixa(
                        cor: generoSelecionado == Genero.feminino
                            ? selecionado
                            : fundo,
                        filho: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.female, size: 80, color: Colors.white),
                            SizedBox(height: 15.0),
                            Text(
                              'FEM',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Seção de altura
            Expanded(
              child: Caixa(
                cor: fundo,
                filho: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ALTURA (cm)',
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                    Text(
                      altura.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Slider(
                      value: altura,
                      onChanged: (novoValor) {
                        setState(() {
                          altura = novoValor;
                        });
                      },
                      min: 60,
                      max: 260,
                    ),
                  ],
                ),
              ),
            ),

            // Seção de peso + resultado
            Expanded(
              child: Row(
                children: [
                  // PESO
                  Expanded(
                    child: Caixa(
                      cor: fundo,
                      filho: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'PESO (kg)',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white70),
                          ),
                          Text(
                            '$peso',
                            style: const TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                heroTag: 'menos',
                                mini: true,
                                backgroundColor: Colors.blueGrey,
                                onPressed: () {
                                  setState(() {
                                    if (peso > 1) peso--;
                                  });
                                },
                                child: const Icon(Icons.remove),
                              ),
                              const SizedBox(width: 10),
                              FloatingActionButton(
                                heroTag: 'mais',
                                mini: true,
                                backgroundColor: Colors.blueGrey,
                                onPressed: () {
                                  setState(() {
                                    peso++;
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

                  // IMC (dinâmico)
                  Expanded(
                    child: Caixa(
                      cor: fundo,
                      filho: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'IMC ATUAL',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white70),
                          ),
                          Text(
                            imc.toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            classificarIMC(imc),
                            style: TextStyle(
                              fontSize: 16,
                              color: _corIMC(imc),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Rodapé
            Container(
              color: const Color(0xFF638ED6),
              width: double.infinity,
              height: alturaBotao,
              margin: const EdgeInsets.only(top: 10.0),
              alignment: Alignment.center,
              child: const Text(
                'IMC DINÂMICO',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Funções auxiliares
  String classificarIMC(double imc) {
    if (imc < 18.5) return 'Abaixo do peso';
    if (imc < 25) return 'Peso normal';
    if (imc < 30) return 'Sobrepeso';
    return 'Obesidade';
  }

  Color _corIMC(double imc) {
    if (imc < 18.5) return Colors.yellowAccent;
    if (imc < 25) return Colors.greenAccent;
    if (imc < 30) return Colors.orangeAccent;
    return Colors.redAccent;
  }
}

// Widget genérico reutilizável
class Caixa extends StatelessWidget {
  final Color cor;
  final Widget? filho;

  const Caixa({required this.cor, this.filho, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: cor,
      ),
      child: filho,
    );
  }
}
