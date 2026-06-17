import 'package:flutter/material.dart';
import 'package:revisai/Compents/Page/auth/Cadastro_page.dart';
import 'package:revisai/Compents/Page/auth/Login_page.dart';
import 'package:revisai/Compents/Page/index/Index_page.dart';
import 'package:revisai/Compents/Page/index/flashcard/FlashCard_Page.dart';

class AppWidget extends StatelessWidget{



  @override
  Widget build(BuildContext context) {

    Map<String, String> perguntas = {"teste":"teste resposta"};


    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => FlashcardPage(perguntas: perguntas,),
        '/login' : (context) => LoginPage(),
        '/cadastra-se' : (context) => CadastroPage(),
      } ,
    );
  }

    
}
