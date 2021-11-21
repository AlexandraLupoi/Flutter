import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToe());
}

class TicTacToe extends StatelessWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool playerTurn = true;
  List<String> matrix = List<String>.filled(9, '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tic-Tac-Toe'),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: Column(children: <Widget>[
          Expanded(
              flex: 4,
              child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (matrix[index] != 'X' && matrix[index] != '0') {
                              matrix[index] = playerTurn ? 'X' : '0';
                              if (!_check()) {
                                playerTurn = !playerTurn;
                              }
                            }
                          });
                        },
                        child: AnimatedContainer(
                            duration: const Duration(seconds: 3),
                            decoration: BoxDecoration(border: Border.all(color: Colors.orangeAccent)),
                            child: Center(
                                child:
                                    Text(matrix[index], style: const TextStyle(fontSize: 28, color: Colors.green)))));
                  })),
          if (_check() || !matrix.contains(''))
            Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      matrix = List<String>.filled(9, '');
                    });
                  },
                  child: const Text('Play again!'))
            ]))
        ]));
  }

  bool _check() {
    // Check rows
    for (int index = 0; index < 9; index += 3) {
      if (matrix[index] != '') {
        if (matrix[index] == matrix[index + 1] && matrix[index + 1] == matrix[index + 2]) {
          return true;
        }
      }
    }

    // Check columns
    for (int index = 0; index < 3; index++) {
      if (matrix[index] != '') {
        if (matrix[index] == matrix[index + 3] && matrix[index + 3] == matrix[index + 6]) {
          return true;
        }
      }
    }

    //Check diagonals
    if (matrix[4] != '') {
      if (matrix[0] == matrix[4] && matrix[4] == matrix[8]) {
        return true;
      }
      if (matrix[2] == matrix[4] && matrix[4] == matrix[6]) {
        return true;
      }
    }

    return false;
  }
}
