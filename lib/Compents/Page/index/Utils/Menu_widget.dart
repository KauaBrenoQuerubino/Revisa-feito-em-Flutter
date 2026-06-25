import 'package:flutter/material.dart';
import 'package:revisai/Compents/model/Usuario.dart';

class MenuWidget extends StatelessWidget {

  final Usuario usuario;
  const MenuWidget({super.key, required this.usuario});
  @override
  Widget build(BuildContext context) {


    
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            colors: [
              Color(0xFF4FC3F7),
              Color(0xFF1282A2),
            ],
          ),
        ),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  
                },
                icon: Icon(Icons.home, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/deck", arguments: usuario);
                },
                icon: Icon(Icons.folder, color: Colors.white),
              ),
              SizedBox(width: 40),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.bar_chart, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}