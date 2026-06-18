import 'package:flutter/material.dart';
import 'package:revisai/Compents/Page/auth/Cadastro_page.dart';
import 'package:revisai/Compents/Page/auth/Login_page.dart';
import 'package:revisai/Compents/Page/index/Index_page.dart';
import 'package:revisai/Compents/Page/index/flashcard/FlashCard_Page.dart';

class AppWidget extends StatelessWidget{

    List<Map<String, String>> perguntas = [
     {
        "pergunta": "teste4",
        "resposta": "teste resposta"
      },
      {
        "pergunta": "test54",
        "resposta": "teste resposta"
      },
      {
        "pergunta": "test554",
        "resposta": "teste resposta"
      },
      {
        "pergunta": "test554",
        "resposta": "teste resposta"
      },
      {
        "pergunta": "test554",
        "resposta": "teste resposta"
      }
    ];


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      initialRoute: '/cadastrar',
      routes: {
        '/' : (context) => IndexPage(),
        '/login' : (context) => LoginPage(),
        '/cadastrar' : (context) => CadastroPage(),
      } ,
    );
  }

    
}
