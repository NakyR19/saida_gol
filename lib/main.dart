import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool toggle = true;
  bool active = true;
  bool rightOrLeft = true;
  Random random = Random();
  int min = 5;
  Timer? timer;
  int sec = 5; // Valor inicial do temporizador

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
    // Inicializa o Timer com o valor inicial
    startTimer();
  }

  // Método para iniciar o timer com o valor atualizado de sec
  void startTimer() {
    // Inicia o Timer com o valor atual de sec
    timer = Timer.periodic(Duration(seconds: sec), (Timer t) {
      setState(() {
        // Inverte o estado de active e, aleatoriamente, altera toggle e rightOrLeft
        active = !active;
        int randomNumber = random.nextInt(100);
        if (randomNumber >= 50) {
          toggle = !toggle;
        }
        int randomNum = random.nextInt(100);
        if (randomNum >= 50) {
          rightOrLeft = !rightOrLeft;
        }

        // Atualiza 'sec' com um novo valor aleatório
        sec = min + random.nextInt(3);
        // Cancela o Timer atual e reinicia com o novo valor de 'sec'
        timer?.cancel();
        startTimer(); // Reinicia o timer com a nova duração
      });
    });
  }

  @override
  void dispose() {
    // Cancela o Timer ao sair da tela para evitar problemas de memória
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height;

    final availableWidth = mediaQuery.size.width;

    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? Center(
                child: Column(
                  children: [
                    Container(
                      color: active && toggle ? Colors.red : Colors.grey,
                      width: availableWidth,
                      height: availableHeight * 0.5,
                      alignment: Alignment.center,
                      child: active && toggle
                          ? (rightOrLeft
                              ? const Text(
                                  "R",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 150),
                                )
                              : const Text(
                                  "L",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 150),
                                ))
                          : const SizedBox.shrink(),
                    ),
                    Container(
                      color: active && !toggle ? Colors.blue : Colors.grey,
                      width: availableWidth,
                      height: availableHeight * 0.5,
                      alignment: Alignment.center,
                      child: active && !toggle
                          ? (rightOrLeft
                              ? const Text(
                                  "R",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 200),
                                )
                              : const Text(
                                  "L",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 200,
                                  ),
                                ))
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              )
            : SafeArea(
                child: Center(
                  child: Row(
                    children: [
                      Container(
                        color: active && toggle ? Colors.red : Colors.grey,
                        width: availableWidth * 0.5,
                        height: availableHeight,
                        alignment: Alignment.center,
                        child: active && toggle
                            ? (rightOrLeft
                                ? const Text(
                                    "R",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 200),
                                  )
                                : const Text(
                                    "L",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 200),
                                  ))
                            : const SizedBox.shrink(),
                      ),
                      Container(
                        color: active && !toggle ? Colors.blue : Colors.grey,
                        width: availableWidth * 0.5,
                        height: availableHeight,
                        alignment: Alignment.center,
                        child: active && !toggle
                            ? (rightOrLeft
                                ? const Text(
                                    "R",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 150),
                                  )
                                : const Text(
                                    "L",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 150,
                                    ),
                                  ))
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
