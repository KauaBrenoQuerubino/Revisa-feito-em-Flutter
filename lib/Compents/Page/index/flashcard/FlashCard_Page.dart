import 'package:flutter/material.dart';
import 'package:revisai/Compents/model/Deck.dart';
import 'package:flip_card/flip_card.dart';
import 'package:revisai/Compents/service/decks/Decks_service.dart';

class FlashcardPage extends StatefulWidget {
  final Deck perguntas;
  final int nivel;
  const FlashcardPage({Key? key, required this.perguntas, required this.nivel}) : super(key: key);

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  bool mostrarResposta = false;
  int index = 0;

  final service = DecksService();

  final List<int> _erradas = [];

  List<Map<String, String>> _fila = [];

  // ─── Equivalente ao ngOnInit do Angular ───────────────────────────────────
  @override
  void initState() {
    super.initState();
    _inicializarFila();

  }

  void _inicializarFila() {
    final base = List<Map<String, String>>.from(widget.perguntas.flashcards);
    base.shuffle();

  
    final List<Map<String, String>> filaMultiplicada = [];
    for (int i = 0; i < widget.nivel; i++) {
      final copia = List<Map<String, String>>.from(base);
      copia.shuffle(); // embaralha cada bloco diferente
      filaMultiplicada.addAll(copia);
    }

    _fila = filaMultiplicada;
    index = 0;
    _erradas.clear();
  }

  void nao() {
    final cartaErrada = _fila[index];
    _erradas.add(index);

    final int repeticoes = widget.nivel - 1;

    if (repeticoes > 0) {
      
      final restantes = _fila.sublist(index + 1);
      for (int i = 0; i < repeticoes; i++) {
        
        final posicaoAleatoria = restantes.isEmpty
            ? 0
            : (restantes.length * (i + 1) ~/ (repeticoes + 1)).clamp(0, restantes.length);
        restantes.insert(posicaoAleatoria, cartaErrada);
      }
      setState(() {
        _fila = [..._fila.sublist(0, index + 1), ...restantes];
      });
    }

    _avancar();
  }

  
  void sim() {
    _avancar();
  }

 
  void _avancar() {
    if (index < _fila.length - 1) {
      setState(() {
        index++;
        mostrarResposta = false;
      });
    } else {
      _mostrarResultado();
    }
  }

  /// Exibe um resumo ao final da sessão.
  void _mostrarResultado() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Sessão concluída! 🎉"),
        content: Text(
          "Você acertou ${_fila.length - _erradas.length} de ${widget.perguntas.flashcards.length} cartas.\n"
          "Nível: ${widget.nivel}",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Reinicia a fila para uma nova rodada
              _inicializarFila();
            },
            child: const Text("Repetir"),
          ),
          TextButton(
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pop(context)
            },
            child: const Text("Sair"),
          ),
        ],
      ),
    );
  }

  Widget _flashcard(Map<String, String> perguntas) {
        return SizedBox(
          width: double.infinity,
          height: 500,
          child: FlipCard(
            key: ValueKey(index),
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
                      "${index + 1}/${_fila.length}",
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
                      "${index + 1}/${_fila.length}",
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
                  child: _flashcard(_fila[index]),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão voltar (seta esquerda)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (index != 0) {
                          index--;
                          mostrarResposta = false;
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),

                  
                  GestureDetector(
                    onTap: nao,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE05C5C), // vermelho
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 28),
                    ),
                  ),

                  
                  GestureDetector(
                    onTap: sim, // função sim()
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Color(0xFF3AACB8), // ciano/teal
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 28),
                    ),
                  ),

                  // Botão avançar (seta direita)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (index < _fila.length - 1) {
                          index++;
                          mostrarResposta = false;
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_sharp,
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