import 'package:flutter/material.dart';
import 'package:revisai/Compents/Page/index/decks/Decks_widget.dart';
import 'package:revisai/Compents/model/Usuario.dart';

class DecksPage extends StatefulWidget {
  const DecksPage({super.key});

  @override
  State<DecksPage> createState() => _DecksPageState();
}

class _DecksPageState extends State<DecksPage> {

  Widget _body(String idUsuario) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xFF004B87).withOpacity(0.3)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: DecksWidget(idUsuario: idUsuario,)),
            ],
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    final usuario = ModalRoute.of(context)!.settings.arguments as Usuario;

    return Stack(
      children: [
        

        SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/background_primary.png", fit: BoxFit.cover),
        ),
        _body(usuario.id!),
        Positioned(
          bottom: 40,
          right: 20,
          child: FloatingActionButton(onPressed: () {}, 
            shape:  RoundedRectangleBorder( borderRadius: BorderRadius.circular(50), )
            ,backgroundColor: Color(0xFF004B87),
            child: Icon(Icons.add, color: Colors.white) ,),
        )
        
      ],
    );
  }
}