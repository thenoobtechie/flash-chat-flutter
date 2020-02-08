import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MessagesStream extends StatelessWidget {

  final db = Firestore.instance;
  final String currentUserEmail;

  MessagesStream({this.currentUserEmail});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db.collection("messages").snapshots(),
      builder: (context, snapshots) {
        if (!snapshots.hasData) {
          return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ));
        }
        final messages = snapshots.data;
        List<MessageBubble> messageWidgets = [];
        for (var document in messages.documents.reversed) {
          messageWidgets.add(MessageBubble(
            message: document.data["text"],
            sender: document.data["sender"],
            isMe: currentUserEmail == document.data["sender"],
          ));
        }

        return Expanded(
            child: ListView(
              reverse: true,
              padding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              children: messageWidgets,
            ));
      },
    );
  }
}