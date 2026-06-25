import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  Widget _NavBar() {
    return Container(
      width: double.infinity,
      height: 200.0,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: Image.asset("assets/images/Logo_icon.png"),
                    ),
                    Icon(
                      Icons.settings,
                      size: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 22,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Configurações",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins-bold',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _MenuItem(IconData icon, String label) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.grey,
          size: 28,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _MenuItem(Icons.edit, "Editar dados"),
          _MenuItem(Icons.phone, "Fale conosco"),
          _MenuItem(Icons.language, "Selecionar idioma"),
          _MenuItem(Icons.contrast, "Mudar tema"),
          _MenuItem(Icons.logout, "Sair da conta"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_primary.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _NavBar(),
            Expanded(child: _body()),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0, right: 20.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "v1.0.0",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}