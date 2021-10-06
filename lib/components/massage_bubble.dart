import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class MassageBubble extends StatelessWidget {
  MassageBubble({this.massage,this.isMe});

  void printIsMe(){
    print(isMe);
  }

  final bool isMe;

  final DocumentSnapshot massage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${massage.data['sender'].toString().split('@')[0]} ',
            style: TextStyle(fontSize: 10, color: Colors.black54),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),topRight: isMe? Radius.circular(0) : Radius.circular(30),topLeft: isMe ? Radius.circular(30):Radius.circular(0)),
              color: isMe ? Colors.lightBlueAccent: Colors.white,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Text(
                  ' ${massage.data['massage']}',
                  style: TextStyle(fontSize: 16, color: isMe ? Colors.white : Colors.black54),
                  /*textAlign: TextAlign.center,*/
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



