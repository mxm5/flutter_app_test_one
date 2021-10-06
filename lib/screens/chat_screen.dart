import 'package:flutter_app_test_one/components/massage_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_test_one/constants.dart';

final _fireStore = Firestore.instance;

FirebaseUser currentUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'Chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController controller = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String massage;




  // TODO: THIS CAN BE REGISTERED NOW USER OR LOGGED IN USER

  void getCurrentUser() async {
    try {
      currentUser = await _auth.currentUser();
      if (currentUser != null) {
        print(currentUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getMassages() async {
    final QuerySnapshot massages =
    await _fireStore.collection('massages').getDocuments();
    for (DocumentSnapshot massage in massages.documents) {
      print(massage.data);
    }
  }

  void massagesStream() async {
    await for (var snapshot in _fireStore.collection('massages').snapshots()) {
      for (var massage in snapshot.documents) {
        print(massage.data);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
                // getMassages();//worked
                // massagesStream();//worked
                // TODO: ALL WORKS FINE
                //I/flutter (13460): {sender: mmohammadianxprg@gmail.com, massage: hi}
                //I/flutter (13460): {sender: mmohammadianxprg@gmail.com, massage: hhhhhhhj}
                //I/flutter (13460): {sender: mmohammadianxprg@gmail.com, massage: kdkdkdkdkdkdkxk}
                //I/flutter (13460): {sender: mmohammadianxprg@gmail.com, massage: گارپوز علی}
                //I/flutter (13460): {sender: mmohammadianxprg@gmail.com, massage: گمبر علی}
                //I/flutter (13460): {sender: mohammad, massage: hi}
                //I/flutter (13460): {sender: mmohammadianxprg@gmail.com, massage: hi}
                //I/flutter (13460): {sender: mmohammadianxprg@gmail.com, massage: hi}
                //I/flutter (13460): {sender: mmohammadianxprg@gmail.com, massage: hi}
                //I/flutter (13460): {sender: mmohammadianxdev@gmail.com, massage:  نبکبکبکبکبکتزتبکیکیکیکبکبکبکترنر}
                //I/flutter (13460): {sender: mmohammadianxdev@gmail.com, massage: گومبور عالییبیب}
                //I/flutter (13460): {sender: mmohammadianxprg@gmail.com, massage: 1, }
                //I/flutter (13460): {sender: mmohammadianxdev@gmail.com, massage:  نبکبکبکبکبکتزتبکیکیکیکبکبکبکترنر}.
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MassagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      textDirection: TextDirection.rtl,
                      controller: controller,
                      onChanged: (value) {
                        massage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      controller.clear();
                      //Implement send functionality.
                      // TODO : NOT ASYNC
                      if (massage != null && currentUser.email != null) {
                        _fireStore.collection('massages').add(
                            {'massage': massage, 'sender': currentUser.email,'time':DateTime.now()});
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MassagesStream extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('massages').orderBy('time',descending: false).snapshots(),
      builder: (/* BuildContext creates new*/ context,
          /* AsyncSnapshot */ snapshot) {
        // TODO : AsyncSnapshot has a prop called data that stores data and status and some other bool like has data or has error has shit and stuff

        if (!snapshot.hasData) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            ),
          );
        }
        //final List<DocumentSnapshot> massages = snapshot.data.documents;
        // this upper line does not accept reversed
        final massages = snapshot.data.documents.reversed;
        // query snapshot which has documents


        List<MassageBubble> massageWidgets = [];
        for (DocumentSnapshot massage in massages) {
          // TODO :document snapshots all of them has a data  and some other shits values that i don't know and it return s a ------map  MAP  map------
          massageWidgets.add(MassageBubble(massage: massage, isMe : currentUser.email == massage.data['sender'] ));
        }

        return Expanded(
          child: ListView(
            reverse: true,
            children: massageWidgets,
          ),
        );
      },
    );
  }
}


