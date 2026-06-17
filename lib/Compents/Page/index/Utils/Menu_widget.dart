import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

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
                onPressed: () {},
                icon: Icon(Icons.home, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
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