import 'package:flutter/material.dart';
import 'package:revisai/Compents/Page/auth/Cadastro_page.dart';
import 'package:revisai/Compents/Page/auth/Login_page.dart';
import 'package:revisai/Compents/Page/index/Index_page.dart';

class AppWidget extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => IndexPage(),
        '/login' : (context) => LoginPage(),
        '/cadastra-se' : (context) => CadastroPage(),
      } ,
    );
  }

    
}
