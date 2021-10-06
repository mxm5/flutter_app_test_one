import 'package:flutter/material.dart';
import 'package:flutter_app_test_one/screens/welcome_screen.dart';
import 'package:flutter_app_test_one/screens/login_screen.dart';
import 'package:flutter_app_test_one/screens/registration_screen.dart';
import 'package:flutter_app_test_one/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,

//      home: WelcomeScreen(),// conflicts with the route prop man

     // this type of routing makes TYPO MISTAKES SO WE USE SOME OTHER WAYS LIKE ID GIVING
      // initialRoute: WelcomeScreen().id,
      // making object every time does not worth it because of cpu usage

      initialRoute: WelcomeScreen.id,

    routes: {
      WelcomeScreen.id: (context) => WelcomeScreen(),
      RegistrationScreen.id: (context) => RegistrationScreen(),
      LoginScreen.id: (context) => LoginScreen(),
      ChatScreen.id: (context) => ChatScreen(),
    },
    );
  }
}
