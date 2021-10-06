import 'package:flutter/material.dart';
import 'package:flutter_app_test_one/screens/registration_screen.dart';
import 'package:flutter_app_test_one/screens/login_screen.dart';

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
      duration: Duration(seconds:2, milliseconds: 50),
      vsync: this,
      // upperBound: 100 // double all out of range 0 to 1 will conflict CURVES
    );


    animation = CurvedAnimation(parent: animationController,curve: Curves.decelerate);

    animationController.forward(); // for moving forward in time
//    animationController.reverse(from: 1.0);  // but to back in time we should use reverse from

    animation.addStatusListener((status){
      print(status);

      if ( status == AnimationStatus.completed){
        animationController.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed){
        animationController.forward();
      }

      // printing is a way that we can assure types
    }); // (AnimationStatus) {  } goes as listener

    animation.addListener(() {
      setState(() {
        // how we put here no value i kind of know
      });
      print(animation.value);
      print(animation.status); // prints animationStatus.reverse and AnimationStatus.dismissed
      // and AnimationStatus.completed
    });
  }


  //TODO : THIS ANIMATIONS WONT LETTING GO OF RESOURCES TILL MANUALLY DISPOSAL
  @override
  void dispose() {
    super.dispose();

    animationController.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    height: animation.value*100,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 37.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //Go to login screen.
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
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
