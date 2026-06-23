import 'dart:js_interop';

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
                          abrirModal(context, Deck);
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
                        onPressed: () {},
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


  void abrirModal(BuildContext context, Deck deck) {
    final perguntaController = TextEditingController();
    final respostaController = TextEditingController();

    String pergunta = '';
    String resposta = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Novo Flashcard",
            textAlign: TextAlign.start,
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 31, 84),
                fontSize: 25,
        
                fontFamily: 'Poppins-bold'
              ),
            ),
          content: 
          Column(
            children: [
              TextField(
                controller: perguntaController,
                onChanged: (value) => pergunta = value,
                keyboardType: TextInputType.emailAddress,
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
              TextField(
                controller: respostaController,
                onChanged: (value) => resposta = value,
                keyboardType: TextInputType.emailAddress,
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Deck>>(
      future: service.listarDecksDoUsuario("QW9ylT9wLLR9gKcSSoIq"),
      builder: (context, snapshot) {
        
      

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print(snapshot.error); // 👈 MOSTRA NO CONSOLE
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