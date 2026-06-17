import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  String email = '';
  String senha = '';

  Widget _body() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            child: Image.asset("assets/images/Logo.png"),
          ),
          Container(height: 30),
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    "Cadastro",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Poppins-bold'
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "Ja possui cadastro? ",
                        ),
                        TextSpan(
                            text: "Entrar",
                            style: TextStyle(
                            color: Color(0xFF001F54),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                        )
                        
                      ]
                    )
                  ),
                ),
                Container(height: 30),
                Column(
                  children: [
                    TextField(
                      onChanged: (value) => email = value,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Seu Nome',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(25),
                           borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                     Container(height: 10),
                    TextField(
                      onChanged: (value) => email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(25),
                           borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    Container(height: 10),
                    TextField(
                      obscureText: true,
                      onChanged: (value) => senha = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    Container(height: 10),
                    TextField(
                      obscureText: true,
                      onChanged: (value) => senha = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Confirmar Senha',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                        ),
                      ),
                      
                    ),
                    Container(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF001F54) // cor do texto
                    ),
                      child: Text('Criar conta'),
                      onPressed: () {
                        if(email == 'Teste' && senha == '123'){
                          Navigator.of(context).pushReplacementNamed('/home');
                        }else{
                          print('error');
                        }
                      }, 
                    ),

                  ],
                ),
                
              ],
            ),
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/background_primary.png", fit: BoxFit.cover),
          ),
          _body()
        ],
      ),
    );
  }
}