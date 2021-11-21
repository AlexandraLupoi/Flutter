import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BasicPhrases());
}

class BasicPhrases extends StatelessWidget {
  const BasicPhrases({Key? key}) : super(key: key);

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
  List<String> phrases = [
    'Bună!',
    'Salut!',
    'Ce faci?',
    "Qu'est-ce que tu fais?",
    'Sunt bine.',
    'Je vais bien.',
    'Mă numesc ... .',
    "Je m'appelle ... .",
    'Am 20 de ani.',
    "J'ai 20 ans."
  ];
  String ro = 'https://translate.google.com/translate_tts?ie=UTF-&&client=tw-ob&tl=ro&q=';
  String fr = 'https://translate.google.com/translate_tts?ie=UTF-&&client=tw-ob&tl=fr&q=';
  List<String> words = [
    '[buna]',
    '[salut]',
    '[ce faci?]',
    "[qu'est-ce que tu fais?]",
    '[sunt bine]',
    '[je vais bien]',
    '[ma numesc]',
    "[je m'appelle]",
    '[am 20 de ani]',
    "[j'ai 20 ans]"
  ];

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Basic Phrases'), centerTitle: true),
        body: GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    _play(index);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          border: Border.all(width: 15, color: Colors.white),
                          borderRadius: const BorderRadius.all(Radius.circular(30))),
                      child: Center(child: Text(phrases[index]))));
            }));
  }

  Future<void> _play(int index) async {
    final String language = index.isEven ? ro : fr;
    final String path = language + words[index];
    await audioPlayer.play(path);
  }
}
