import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/signin.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chatme App',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      initialRoute: _auth.currentUser != null
          ? ChatScreen.screenRout
          : WelcomeScreen.screenRout,
      routes: {
        WelcomeScreen.screenRout: (ctx) => WelcomeScreen(),
        LoginScreen.screenRout: (ctx) => LoginScreen(),
        RegistrationScreen.screenRout: (ctx) => RegistrationScreen(),
        ChatScreen.screenRout: (ctx) => ChatScreen(),
      },
    );
  }
}