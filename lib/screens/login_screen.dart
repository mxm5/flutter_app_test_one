import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_test_one/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test_one/constants.dart';
import 'package:flutter_app_test_one/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'Login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  final _auth = FirebaseAuth.instance;

  bool loading= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  _email = value;
                },
                decoration:
                    KTextInputDecorationStyle.copyWith(hintText: 'Enter Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                },
                decoration: KTextInputDecorationStyle.copyWith(
                    hintText: 'Enter Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  title: 'Login',
                  color: Colors.lightBlueAccent,
                  onPress: () async {
                    print(' email = $_email pass = $_password');
                    setState(() {
                      loading =true;
                    });
                    // I/flutter ( 3709):  email = mmohammadianxprg@gmail.com pass = xnjxnxmkxb .
                    try {
                      final loggingUser = await _auth.signInWithEmailAndPassword(
                          email: _email, password: _password);
                      //TODO : THIS IS RETURNING AN AUTHRESAULT OBJECT AND WE DON'T ASSIGN ANY TYPE WITH IT IF WE USE FINALLLLLL
                      if (loggingUser != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                      }

                    } catch (e) {
                      print(e);
                    }

                    setState(() {
                      loading = false;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
