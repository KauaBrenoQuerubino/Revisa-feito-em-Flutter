import 'package:flutter/material.dart';
import 'package:revisai/Compents/Page/auth/Cadastro_page.dart';
import 'package:revisai/Compents/Page/auth/Login_page.dart';
import 'package:revisai/Compents/Page/index/Index_page.dart';
import 'package:revisai/Compents/Page/index/Utils/Config_page.dart';
import 'package:revisai/Compents/Page/index/decks/Decks_page.dart';


class AppWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      initialRoute: '/login',
      routes: {
        '/' : (context) => IndexPage(),
        '/deck' : (context) => DecksPage(),
        '/config' : (context) => ConfigPage(),
        '/login' : (context) => LoginPage(),
        '/cadastrar' : (context) => CadastroPage(),
      } ,
    );
  }

    
}
