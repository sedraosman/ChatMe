import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widget/my_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class LoginScreen extends StatefulWidget {
  static const screenRout = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  height: 200,
                  child:  Image.asset('images/logo1.png'),
                 ),
                 SizedBox(height: 30),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8),
                   child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (Valu){
                      email = Valu;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Your Email',
                      enabledBorder: 
                     OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20)
                      )
                     ),
                      focusedBorder:
                      OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurpleAccent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20))
                      ) ,
                    ),
                   ),
                 ),
                 SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      obscureText: true,
                    onChanged: (Valu){
                      password = Valu;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      enabledBorder: 
                     OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20)
                      )
                     ),
                      focusedBorder:
                      OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.deepPurpleAccent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20))
                      ) ,
                    ),
                                   ),
                  ),
                 SizedBox(height: 20),
                 myButton(color:  Colors.deepPurpleAccent, title: 'Sing In', 
                 function: ()async{
                  setState(() {
                    showSpinner = true;

                  });
                  
                    try{
                      final userIn = await _auth.signInWithEmailAndPassword(
                    email: email, password: password);
                    if(userIn != null){
                      Navigator.pushNamed(context, ChatScreen.screenRout);
                      setState(() {
                        showSpinner = false;
                      });
                    }
                    }
                    catch(e){
                      print(e);
                    }
        
                 })
            ],
          ),
        ),
      ),
    );
  }
}