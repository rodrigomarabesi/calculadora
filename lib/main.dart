import 'sobre.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const CalculadoraView(),
    );
  }
}

class CalculadoraView extends StatefulWidget {
  const CalculadoraView({super.key});

  @override
  State<CalculadoraView> createState() => _CalculadoraViewState();
}

class _CalculadoraViewState extends State<CalculadoraView> {
  String equacao = "0";
  String resultado = "0";
  String expressao = "";

  botaoPressionado(String textoBotao) {
    String contemDecimal(dynamic resultado) {
      if (resultado.toString().contains(',')) {
        List<String> splitDecimal = resultado.toString().split(',');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return resultado = splitDecimal[0].toString();
        }
      }
      return resultado;
    }

    setState(() {
      if (textoBotao == "C") {
        equacao = "0";
        resultado = "0";
      } else if (textoBotao == "CE") {
        equacao = equacao.substring(0, equacao.length - 1);
        if (equacao == "") {
          equacao = "0";
        }
      } else if (textoBotao == "+/-") {
        if (equacao[0] != '-') {
          equacao = '-$equacao';
        } else {
          equacao = equacao.substring(1);
        }
      } else if (textoBotao == "=") {
        expressao = equacao;
        expressao = expressao.replaceAll('x', '*');
        expressao = expressao.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expressao);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          //Limita resultados até 5 casas decimais
          if (expressao.contains('/')) {
            String formattedResult = eval.toString();
            if (formattedResult.contains('.') &&
                formattedResult.split('.')[1].length > 5) {
              resultado = eval.toStringAsFixed(5);
            } else {
              resultado = formattedResult;
            }
          } else {
            resultado = eval.toString();
          }

          if (expressao.contains('%')) {
            resultado = contemDecimal(resultado);
          }
        } catch (e) {
          resultado = "Erro";
        }
      } else {
        if (equacao == "0") {
          equacao = textoBotao;
        } else {
          equacao = equacao + textoBotao;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                resultado,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 80),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(equacao,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: Color.fromARGB(97, 196, 192, 192),
                                  )),
                            ),
                            IconButton(
                              icon: const Icon(Icons.backspace_outlined,
                                  color: Color.fromARGB(255, 105, 158, 228),
                                  size: 30),
                              onPressed: () {
                                botaoPressionado("CE");
                              },
                            ),
                            const SizedBox(width: 20),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    botaoCalculadora('%', const Color.fromRGBO(97, 97, 97, 1),
                        () => botaoPressionado('%'), Colors.white),
                    botaoCalculadora('CE', const Color.fromRGBO(97, 97, 97, 1),
                        () => botaoPressionado('CE'), Colors.white),
                    botaoCalculadora('C', const Color.fromRGBO(97, 97, 97, 1),
                        () => botaoPressionado('C'), Colors.white),
                    botaoCalculadora('÷', const Color.fromRGBO(97, 97, 97, 1),
                        () => botaoPressionado('÷'), Colors.white),
                    botaoCalculadora(
                        '7',
                        const Color.fromRGBO(117, 117, 117, 1),
                        () => botaoPressionado('7'),
                        Colors.black),
                    botaoCalculadora(
                        '8',
                        const Color.fromRGBO(117, 117, 117, 1),
                        () => botaoPressionado('8'),
                        Colors.black),
                    botaoCalculadora(
                        '9',
                        const Color.fromRGBO(117, 117, 117, 1),
                        () => botaoPressionado('9'),
                        Colors.black),
                    botaoCalculadora('x', const Color.fromRGBO(97, 97, 97, 1),
                        () => botaoPressionado('x'), Colors.white),
                    botaoCalculadora(
                        '4',
                        const Color.fromRGBO(117, 117, 117, 1),
                        () => botaoPressionado('4'),
                        Colors.black),
                    botaoCalculadora(
                        '5',
                        const Color.fromRGBO(117, 117, 117, 1),
                        () => botaoPressionado('5'),
                        Colors.black),
                    botaoCalculadora(
                        '6',
                        const Color.fromRGBO(117, 117, 117, 1),
                        () => botaoPressionado('6'),
                        Colors.black),
                    botaoCalculadora('-', const Color.fromRGBO(97, 97, 97, 1),
                        () => botaoPressionado('-'), Colors.white),
                    botaoCalculadora(
                        '1',
                        const Color.fromRGBO(117, 117, 117, 1),
                        () => botaoPressionado('1'),
                        Colors.black),
                    botaoCalculadora(
                        '2',
                        const Color.fromRGBO(117, 117, 117, 1),
                        () => botaoPressionado('2'),
                        Colors.black),
                    botaoCalculadora(
                        '3',
                        const Color.fromRGBO(117, 117, 117, 1),
                        () => botaoPressionado('3'),
                        Colors.black),
                    botaoCalculadora('+', const Color.fromRGBO(97, 97, 97, 1),
                        () => botaoPressionado('+'), Colors.white),
                    botaoCalculadora(
                        '+/-',
                        const Color.fromRGBO(117, 117, 117, 1),
                        () => botaoPressionado('+/-'),
                        Colors.black),
                    botaoCalculadora(
                        '0',
                        const Color.fromRGBO(117, 117, 117, 1),
                        () => botaoPressionado('0'),
                        Colors.black),
                    botaoCalculadora(
                        '.',
                        const Color.fromRGBO(117, 117, 117, 1),
                        () => botaoPressionado('.'),
                        Colors.black),
                    botaoCalculadora('=', Colors.blue,
                        () => botaoPressionado('='), Colors.white),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TelaSobre()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Sobre',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget botaoCalculadora(String textoDoBotao, Color corDoBotao,
    Function? aoPressionarBotao, Color corDoTexto) {
  return ElevatedButton(
    onPressed: () {
      if (aoPressionarBotao != null) {
        aoPressionarBotao();
      }
    },
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      backgroundColor: corDoBotao,
    ),
    child: Text(
      textoDoBotao,
      style: TextStyle(
        fontSize: 25,
        color: corDoTexto,
      ),
    ),
  );
}
