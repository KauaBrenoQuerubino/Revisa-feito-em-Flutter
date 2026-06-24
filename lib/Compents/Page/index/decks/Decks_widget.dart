import 'dart:io';
import 'dart:js_interop';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:revisai/Compents/Page/index/flashcard/FlashCard_Page.dart';
import 'package:revisai/Compents/model/Deck.dart';
import 'package:revisai/Compents/service/decks/Decks_service.dart';

class DecksWidget extends StatefulWidget {

  final String? idUsuario;

  const DecksWidget({super.key, required this.idUsuario,});

  @override
  State<DecksWidget> createState() => _DecksWidgetState();
}

class _DecksWidgetState extends State<DecksWidget> {

  DecksService service = DecksService();



  Widget _deck(Deck Deck) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 199, 235, 252)
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 20.0, 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              width: 70,
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),

              child: Image.asset("assets/images/Categoria1.png", fit: BoxFit.cover,),

            ),
            SizedBox(width: 5,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Deck.titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 31, 84),
                      fontFamily: "Poppins-bold",
                      fontSize: 17
                    ),
                  ),
                  Text(
                    "Total: ${Deck.flashcards.length}",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 31, 84),
                          fontSize: 15
                      ),
                  )
                ],
              ),
            ),
              Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "",
                   style: TextStyle(
                        color: Color.fromARGB(255, 0, 31, 84),
                        fontSize: 15
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                  Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                        color: Color(0xFF001F54),
                        borderRadius: BorderRadius.circular(4),
                    ),
                      child: IconButton(
                        onPressed: () {
                          novoFlashcard(context, Deck);
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                     Container(width: 5,),
                      Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                        color: Color(0xFF001F54),
                        borderRadius: BorderRadius.circular(4),
                    ),
                      child: IconButton(
                        onPressed: () {
                          editarDeck(context, Deck);
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 15,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    Container(width: 5,),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF001F54),
                        borderRadius: BorderRadius.circular(4),
                    ),
                      child: IconButton(
                        onPressed: () {
                          if(Deck.flashcards.length > 0) {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context) =>  
                                FlashcardPage(perguntas: Deck.flashcards)),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    )
                   
                  ],
                )
              ],
            ),
          
          
          ]
        ),
      ),
    );
  }

  Future<PlatformFile?> selecionarArquivo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      var file = result.files.first;
      return file;
    } else {
      return null;
    }
  }

  void gerarFlashcard(BuildContext context, Deck deck) {
    final conteudoController = TextEditingController();

    String conteudo = '';
    double valor = 1;
    bool carregando = false;
    PlatformFile? arquivo = null;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Gerar Flashcard",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 31, 84),
                  fontSize: 20,
                  fontFamily: 'Poppins-bold',
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Stack(
                children: [
                   IgnorePointer(
                      ignoring: carregando,
                      child: Opacity(
                        opacity: carregando ? 0.4 : 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                               Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: conteudoController,
                                  onChanged: (value) => conteudo = value,
                                  maxLines: 5,
                                  minLines: 3,
                                  decoration: InputDecoration(
                                    labelText: 'Descrever Conteúdo',
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 199, 199, 199),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                Container(height: 20,),
                                Text(
                                  "Nome do arquivo: ${arquivo?.name}", 
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                                Container(height: 10,),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color(0xFF001F54) // cor do texto
                                  ),
                                  onPressed: () async {
                                    final file = await selecionarArquivo();

                                    setState(() {
                                      arquivo = file;
                                    });
                                                          
                                    },
                                  child: Text("Selecionar arquivo"),
                                ),

                                SizedBox(height: 30),

                                Text("Quantidade: ${valor.toInt()}"),

                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Color(0xFF001F54),     // parte preenchida
                                    inactiveTrackColor: const Color.fromARGB(255, 173, 173, 173),   // parte vazia
                                    thumbColor: Color(0xFF001F54),            // bolinha
                                    overlayColor: Color(0xFF001F54).withOpacity(0.2), // efeito ao clicar

                                    trackHeight: 6, // altura da barra

                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 10, // tamanho da bolinha
                                    ),

                                    overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 20,
                                    ),

                                    valueIndicatorColor: Colors.black, // fundo do label
                                    valueIndicatorTextStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Slider(
                                    value: valor,
                                    min: 1,
                                    max: 25,
                                    divisions: 24,
                                    label: valor.toInt().toString(),
                                    onChanged: (novoValor) {
                                      setState(() {
                                        valor = novoValor;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                   ),
                    if (carregando)
                      Positioned.fill(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 10),
                              Text("Gerando flashcards...")
                            ],
                          ),
                        ),
                      ),
                ]   
                ),
              ),
                actions: [
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF001F54) // cor do texto
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancelar"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF001F54) // cor do texto
                    ),
                    
                onPressed: () async {
                    setState(() {
                      carregando = true;
                    });

                    try {
                      if (arquivo == null) {
                        final data = await service.gerarFlashcards(
                          conteudo,
                          valor.toInt(),
                        );

                        for (var item in data) {
                          deck.flashcards.add({
                            "pergunta": item["pergunta"],
                            "resposta": item["resposta"],
                          });
                        }
                      } else {
                        final data = await service.gerarFlashcardsPorPDF(
                          arquivo!,
                          valor.toInt(),
                        );

                        for (var item in data) {
                          deck.flashcards.add({
                            "pergunta": item["pergunta"],
                            "resposta": item["resposta"],
                          });
                        }
                      }

                      await service.atualizarDeck(deck);

                      Navigator.pop(context);
                    } finally {
                      setState(() {
                        carregando = false;
                      });
                    }
                  },
                    child: Text("Gerar"),
                  ),
                ],
            );
          },
        );
      },
    );
  }
  
  void novoFlashcard(BuildContext context, Deck deck) {
    final perguntaController = TextEditingController();
    final respostaController = TextEditingController();

    String pergunta = '';
    String resposta = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(
                "Novo Flashcard",
                textAlign: TextAlign.start,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 31, 84),
                    fontSize: 20,
                      
                    fontFamily: 'Poppins-bold'
                  ),
                ),
                IconButton(onPressed: () {
                  gerarFlashcard(context, deck);
                }, style: ButtonStyle(
                   foregroundColor: WidgetStatePropertyAll( Colors.white),
                   backgroundColor:  WidgetStatePropertyAll(Color(0xFF001F54))
                ) , icon: Icon(Icons.smart_toy))
            ],
          ),
          content: 
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: perguntaController,
                onChanged: (value) => pergunta = value,
                decoration: InputDecoration(
                  labelText: 'pergunta',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 199, 199, 199),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                  ),
                )        
              ),
              Container(height: 10,),
              TextField(
                controller: respostaController,
                onChanged: (value) => resposta = value,
                decoration: InputDecoration(
                  labelText: 'resposta',
                  filled: true,
                  fillColor: const Color.fromARGB(255, 199, 199, 199),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                  ),
                )        
              ),
            ],
          ),
        
          actions: [
            TextButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF001F54) // cor do texto
              ),
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF001F54) // cor do texto
              ),
              
              onPressed: () {
                deck.flashcards.add({
                  "pergunta": pergunta,
                  "resposta": resposta
                });

                service.atualizarDeck(deck);
              },
              child: Text("Salvar"),
            ),
            
          ],
        );
      },
    );
  }

  void editarDeck(BuildContext context, Deck deck) {
    final tituloController = TextEditingController(text: deck.titulo);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Editar Deck",
            style: TextStyle(
              color: Color.fromARGB(255, 0, 31, 84),
              fontSize: 20,
              fontFamily: 'Poppins-bold',
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloController,
                onChanged: (value) => {deck.titulo = value},
                decoration: InputDecoration(
                  labelText: 'Título',
                  filled: true,
                  fillColor: Color.fromARGB(255, 199, 199, 199),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [

            Row(
                children: [
                TextButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    service.deletarDeck(deck.id);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delete, size: 16),
                      SizedBox(width: 4),
                      Text("Apagar"),
                    ],
                  ),
                ),
                Container(width: 2,),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF001F54),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar"),
                ),
                Container(width: 2,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF001F54),
                  ),
                  onPressed: () {
                    service.atualizarDeck(deck);
                  },
                  child: Text("Salvar"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Deck>>(
      future: service.listarDecksDoUsuario("QW9ylT9wLLR9gKcSSoIq"),
      builder: (context, snapshot) {
        

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Erro: ${snapshot.error}"));
        }

        final decks = snapshot.data ?? [];



        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 20),
          itemCount: decks.length,
          itemBuilder: (context, index) {
            print(decks[index].flashcards);
            return _deck(decks[index]);
          },
          separatorBuilder: (_, __) => SizedBox(height: 12),
        );
      },
    );
  }
}