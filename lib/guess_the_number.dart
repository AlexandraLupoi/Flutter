import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const GuessTheNumber());
}

class GuessTheNumber extends StatelessWidget {
  const GuessTheNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? text;
  int? numberTried;
  String buttonText = 'Check!';
  int random = Random().nextInt(99) + 1;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess the number'),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.all(10),
            child: Text(
              'I\'m thinking of a number between 1 and 100.',
              style: TextStyle(
                fontSize: 19
              )
            )
          ),
          const Padding(
            padding: EdgeInsetsDirectional.all(10),
            child: Text(
              'Try to guess the number.',
              style: TextStyle(
                fontSize: 17
              )
            )
          ),
          if(numberTried != null && numberTried != random)
            Text('Number tried: $numberTried'),
          if(numberTried != null && numberTried != random)
            Text('$text'),
          Padding(
            padding: const EdgeInsetsDirectional.all(13),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(
                  color: Colors.black12,
                  width: 2.5
                )
              ),
              child: Column(
                children: [
                  const ListTile(
                    title: Center(
                      child: Text(
                        'Enter a number!',
                        style: TextStyle(
                          fontSize: 23,
                          letterSpacing: 1.5
                        )
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: TextField(
                      controller: controller,
                      enabled: buttonText == 'Check!' ? true : false,
                      keyboardType: const TextInputType.numberWithOptions()
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      child: Text(buttonText),
                      onPressed: () {
                        setState(() {
                          if(buttonText == 'Play again!') {
                            numberTried = null;
                            buttonText = 'Check!';
                            random = Random().nextInt(99) + 1;
                          } else {
                            text = int.tryParse(controller.text)! > random
                                ? 'Try lower'
                                : 'Try higher';
                            numberTried = int.tryParse(controller.text);
                            if(numberTried == random) {
                              FocusScope.of(context).unfocus();
                              controller.clear();
                              buttonText = 'Play again!';
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Congrats! You guessed right.'),
                                    content: Text('It was $random.'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Play again!'),
                                        onPressed: () {
                                          setState(() {
                                            numberTried = null;
                                            buttonText = 'Check!';
                                            random = Random().nextInt(99) + 1;
                                          });
                                          Navigator.pop(context);
                                        }
                                      ),
                                      TextButton(
                                        child: const Text('Yey!!'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }
                                      )
                                    ]
                                  );
                                }
                              );
                            }
                          }
                        });
                      }
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}
