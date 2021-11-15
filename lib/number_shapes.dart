import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const NumberShapes());
}

class NumberShapes extends StatelessWidget {
  const NumberShapes({Key? key}) : super(key: key);

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
  bool square = false;
  bool triangular = false;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Number shapes'), centerTitle: true),
      body: Column(children: <Widget>[
        const Padding(
            padding: EdgeInsetsDirectional.all(10),
            child: Text(
              'Please input a number to see if it is square or triangular.',
              style: TextStyle(fontSize: 20),
            )),
        Padding(
          padding: const EdgeInsetsDirectional.all(20),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () {
            final double numberToCheck = double.tryParse(controller.text)!;
            final double base2 = pow(numberToCheck, 1.0 / 2.0).roundToDouble();
            final double base3 = pow(numberToCheck, 1.0 / 3.0).roundToDouble();

            FocusScope.of(context).unfocus();
            setState(() {
              square = pow(base2, 2) == numberToCheck;
              triangular = pow(base3, 3) == numberToCheck;
              showDialog<void>(
                  context: context,
                  builder: (BuildContext builder) {
                    return AlertDialog(
                        title: Text(controller.text),
                        content: !square && !triangular
                            ? Text('Number ${controller.text} is neither SQUARE or TRIANGULAR!')
                            : !square && triangular
                                ? Text('Number ${controller.text} is TRIANGULAR!')
                                : square && !triangular
                                    ? Text('Number ${controller.text} is SQUARE!')
                                    : square && triangular
                                        ? Text('Number ${controller.text} is both SQUARE and TRIANGULAR!')
                                        : null);
                  });
            });
          }),
    );
  }
}
