import 'package:chat_app/screens/signin.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import '../widget/my_button.dart';


class WelcomeScreen extends StatefulWidget {
  static const screenRout = '/welcome';
 

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 250.0,
                  child: Image.asset('images/logo1.png'),
                ),
                Text('ChatMe',
                style: TextStyle(
                  fontSize:40,
                  fontWeight: FontWeight.w900,
                  color: const Color.fromARGB(255, 3, 32, 86)
                ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            myButton(color:Colors.deepPurpleAccent,
            title: 'Sign In',
            function: (){
              Navigator.of(context).pushNamed(LoginScreen.screenRout);
          
            },),
            myButton(color: Color(0xFF0871B0),
            title: ' Register',
            function: (){
               Navigator.of(context).pushNamed(RegistrationScreen.screenRout);
          
            },),
          ],
        ),
      ),
    );
    
  }
}
