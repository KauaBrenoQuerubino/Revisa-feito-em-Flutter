import 'package:flutter/material.dart';
import 'package:revisai/Compents/model/Deck.dart';
import 'package:flip_card/flip_card.dart';

class FlashcardPage extends StatefulWidget {
  final List<Map<String, String>> perguntas;
  const FlashcardPage({Key? key, required this.perguntas}) : super(key: key);

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  bool mostrarResposta = false;
  int index = 0;

  Widget _flashcard(Map<String, String> perguntas) {
        return SizedBox(
          width: double.infinity,
          height: 500,
          child: FlipCard(
            direction: FlipDirection.HORIZONTAL,
            speed: 500,

            front: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${index + 1}/${widget.perguntas.length}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          perguntas["pergunta"] ?? "Sem pergunta",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),

                    const Text(
                      "Toque para ver a resposta",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            back: Card(
              color: const Color(0xFF001F54),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${index + 1}/${widget.perguntas.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Expanded(
                      child: Center(
                        child: Text(
                          perguntas["resposta"] ?? "Sem resposta",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),

                    const Text(
                      "Toque para voltar",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

  Widget _body() {


    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(60.0, 100.0, 60.0, 100.0),
        child: Container(
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: _flashcard(widget.perguntas[index]),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (index != 0) {
                          index--;
                          mostrarResposta = false;
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_back_sharp, 
                    color: Colors.white,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (index < widget.perguntas.length - 1) {
                          index++;
                          mostrarResposta = false;
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_forward_sharp, 
                    color: Colors.white,
                    size: 35,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
         ClipRRect(
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