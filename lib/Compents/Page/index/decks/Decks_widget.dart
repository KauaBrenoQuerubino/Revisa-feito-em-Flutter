import 'package:flutter/material.dart';
import 'package:revisai/Compents/model/Deck.dart';

class DecksWidget extends StatefulWidget {
  const DecksWidget({super.key});

  @override
  State<DecksWidget> createState() => _DecksWidgetState();
}

class _DecksWidgetState extends State<DecksWidget> {

  Widget _deck(Deck Deck) {

    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 199, 235, 252)
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              width: 100,
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),

              child: Image.asset("assets/images/Categoria1.png", fit: BoxFit.cover,),

            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Deck.nome,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 31, 84),
                    fontFamily: "Poppins-bold",
                    fontSize: 15
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
             SizedBox(width: 10),
               Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  " 2 dias",
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
                        onPressed: () {},
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
                        onPressed: () {},
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


  @override
  Widget build(BuildContext context) {
    List<Deck> decks = [
      Deck(nome: "Programacao Java", titulo: "TesteTitulo", flashcards: [{"teste":"teste"}])
    ];


    return Column(
        children: [
          Container(height: 20,),
           ...decks.map(
              (deck) => _deck(deck),
            ),
            Container(height: 20,),
        ],
    );
  }
}