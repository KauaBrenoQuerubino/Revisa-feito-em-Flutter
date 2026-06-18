import 'package:flutter/material.dart';
import 'package:revisai/Compents/model/Deck.dart';

class FlashcardPage extends StatefulWidget {
  final List<Map<String, String>> perguntas;
  const FlashcardPage({Key? key, required this.perguntas}) : super(key: key);

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  bool mostrarResposta = false;
  int index = 0; // 👈 agora é estado

  Widget _flashcard(Map<String, String> perguntas) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            mostrarResposta
                ? perguntas["resposta"] ?? "Sem resposta"
                : perguntas["pergunta"] ?? "Sem pergunta",
          ),

          SizedBox(height: 10),

          ElevatedButton(
            onPressed: () {
              setState(() {
                mostrarResposta = !mostrarResposta;
              });
            },
            child: Text(
              mostrarResposta ? "Ver pergunta" : "Ver resposta",
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {


    return Center(
      child: Column(
        children: [
        _flashcard(widget.perguntas[index]),
         IconButton(
            onPressed: () {

              print(widget.perguntas[index]);

              setState(() {

              
              if (index < widget.perguntas.length - 1) {
                index++;
                mostrarResposta = false; // reseta ao trocar
              }
            });
            },
            icon: Icon(Icons.folder, color: Colors.white),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
         ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
            child: Image.asset(
              "assets/images/background_secundary.png",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ), 
        ),
        _body()
      ],
    );
  }
}