import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverter());
}

class CurrencyConverter extends StatelessWidget {
  const CurrencyConverter({Key? key}) : super(key: key);

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
  final TextEditingController controller = TextEditingController();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true
      ),
      body: Column(
        children: [
          Image.network('https://www.ideas.org.au/images/resources/blog/australian-dollars-in-fan-on-wooden-desk-picture-id1014716026.jpg'),
          Container(
            margin: const EdgeInsetsDirectional.all(10),
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true
              ),
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'EURO',
                errorText: errorText
              ),
              onChanged: (String value) {
                if(value.isEmpty) {
                  controller.clear();
                  errorText = null;
                } else {
                  if(double.tryParse(value) != null) {
                    final double convert = double.tryParse(value)! * 4.94;

                    controller.text = convert.toStringAsPrecision(3);
                    errorText = null;
                  } else {
                    controller.clear();
                    errorText = 'This is not a valid number';
                  }
                }
              },
            )
          ),
          Container(
              margin: const EdgeInsetsDirectional.all(10),
              child: TextField(
                controller: controller,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'RON'
                )
              )
          )
        ],
      )
    );
  }
}
