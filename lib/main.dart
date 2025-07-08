import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// Widget principal do app
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int? _randomNumber;
  bool _wasRepeated = false;
  final List<int> _drawnNumbers = [];

  // Gera um número aleatório entre 1 e 10 e atualiza o estado
  void _generateRandomNumber() {
    setState(() {
      final newNumber = Random().nextInt(10) + 1;
      _randomNumber = newNumber;

      if (_drawnNumbers.contains(newNumber)) {
        _wasRepeated = true;
      } else {
        _wasRepeated = false;
        _drawnNumbers.add(newNumber);
      }
    });
  }

  // Reinicia o jogo
  void _resetGame() {
    setState(() {
      _drawnNumbers.clear();
      _randomNumber = null;
      _wasRepeated = false;
    });
  }

  // Texto superior da interface
  Widget _buildInstructionText() {
    return const Text(
      'Hoje é seu dia de sorte! Clique no botão abaixo e confira!',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Mostra o número sorteado ou "???"
  Widget _buildNumberDisplay() {
    return Text(
      _randomNumber?.toString() ?? '???',
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 120,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Alerta caso o número tenha se repetido
  Widget _buildAlertText() {
    if (_wasRepeated && _randomNumber != null) {
      return Text(
        'Número $_randomNumber já sorteado! ❌',
        style: const TextStyle(
          color: Color(0xffd51616),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  // Botão principal de sortear
  Widget _buildSortButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _generateRandomNumber,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff8716d5),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: const Text('SORTE!'),
      ),
    );
  }

  // Lista dos números já sorteados
  Widget _buildHistoryText() {
    if (_drawnNumbers.isEmpty) return const SizedBox.shrink();

    return Text(
      'Números já sorteados:\n${_drawnNumbers.join(', ')}',
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Color(0xff8716d5),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Interface principal
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          backgroundColor: Colors.black87,
          title: const Text(
            'Número da Sorte 🎲',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInstructionText(),
                const SizedBox(height: 20),
                _buildNumberDisplay(),
                const SizedBox(height: 10),
                _buildAlertText(),
                const SizedBox(height: 20),
                _buildSortButton(),
                const SizedBox(height: 20),
                _buildHistoryText(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _resetGame,
          backgroundColor: Colors.black87,
          child: const Icon(Icons.refresh, color: Colors.white),
        ),
      ),
    );
  }
}
