import 'package:flutter/material.dart';
import 'package:flutter_app_test_one/screens/registration_screen.dart';
import 'package:flutter_app_test_one/screens/login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_app_test_one/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'Welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
//    sleep(Duration(seconds: 2)); // it does not work att all

    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
      // upperBound: 100 // double all out of range 0 to 1 will conflict CURVES
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(animationController);

    animationController.forward(); // for moving forward in time

    animation.addListener(() {
      setState(() {
        // how we put here no value i kind of know
      });
      print(animation.value);
      print(animation
          .status); // prints animationStatus.reverse and AnimationStatus.dismissed
      // and AnimationStatus.completed
    });

    animationController.addStatusListener((st) {
      if (st == AnimationStatus.completed) {
        animationController.dispose();
        print('disposssed');
      }
    });
  }

  //TODO : THIS ANIMATIONS I MADE WONT LETTING GO OF RESOURCES TILL MANUALLY DISPOSAL
  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  //TODO : does not need mixin
                  text: ['Flash Chat', 'simple', 'fast', 'secure'],
                  totalRepeatCount: 20,
                  //TODO : I BROKE THE LOOP GOES FOR EVER BUT PUT POSITIVE NUMBER
                  isRepeatingAnimation: true,
                  speed: Duration(milliseconds: 500),
                  // speed of typing
                  pause: Duration(milliseconds: 500),
                  // how much waiting after pressing
                  textStyle: TextStyle(
                    fontSize: 37.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log in',
              color: Colors.lightBlueAccent,
              onPress: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
                title: 'Register',
                color: Colors.blueAccent,
                onPress: () {
                  //Go to registration screen.
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }),
          ],
        ),
      ),
    );
  }
}
