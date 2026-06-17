import 'package:flutter/material.dart';
import 'package:revisai/Compents/Page/index/Utils/Menu_widget.dart';
import 'package:revisai/Compents/Page/index/decks/Decks_widget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {


  Widget _NavBar(){
     return Container(
      width: double.infinity,
      height: 230.0,

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
              alignment: Alignment.topCenter,
            ),
           
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
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
                      Icons.account_circle,
                      size: 50,
                      color: Colors.white,
                    )
                  ],
                ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          "Olá, usuarioName",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Poppins'
                        ),
                      ),
                      Text(
                        "Bem-vindo de volta",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Poppins-bold'
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ],
            ),
          ),
        ]
      )
    );
  }

  Widget _body() {
   return Padding(
     padding: const EdgeInsets.all(20.0),
     child: Container(
      width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Meus decks:",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 31, 84),
                fontSize: 18,
        
                fontFamily: 'Poppins-bold'
              ),
            ),
            Expanded(child: DecksWidget()),
          ],
        ),
      ),
   );
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: FloatingActionButton(
          onPressed: () {},
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50), )
          , backgroundColor: Color(0xFF004B87),
           child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: MenuWidget(),

      body: Column(
        children: [
          _NavBar(),
         Expanded(child:  _body(), ),
        ],
      ),
    );
  }
}


// return Material(
//       child: Column(
//         children: [
//           // MenuWidget(),
//           _NavBar(),
//           Expanded(child:  _body(), ),
//           Expanded(child: MenuWidget()),
    
        
//         ],

//       ),
//     );