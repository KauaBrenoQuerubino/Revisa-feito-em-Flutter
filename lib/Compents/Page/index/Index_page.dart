import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {


  Widget _NavBar(){
     return Container(
      width: double.infinity,
      height: 250.0,

      child: Stack(

        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
            child: Image.asset(
              "assets/images/background_primary.png",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
           
          ),
          Column(
            children: [
              Row(
                children: [
                  Text("Logo aqui"),
                  Text("Usuario icon aqui")
                ],
              ),
              Column(
                children:[  Text("Ola, usuarioName"), Text("Bem vindo de volta")],
              ),
              Container(
                height: 50,
              ),
            ],
          ),
        ]
      )
    );
  }

  Widget _body() {
   return SizedBox();
  }




  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          _NavBar(),
          _body()
        ],

      ),
    );
  }
}