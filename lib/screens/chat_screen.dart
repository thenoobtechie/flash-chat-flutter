import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/messages_stream.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "/chat_screen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final db = Firestore.instance;
  final msgTxtController = TextEditingController();

  FirebaseUser loggedInUser;
  String message;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
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
            MessagesStream(currentUserEmail: loggedInUser!=null ? loggedInUser.email : "",),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgTxtController,
                      style: kSendMessageTextStyle,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration.copyWith(
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      //Implement send functionality.
                      if(message.isNotEmpty) {
                        msgTxtController.clear();
                        await addMessageInDB(message);
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

  void getCurrentUser() async {
    final currentUser = await _auth.currentUser();
    if (currentUser != null) {
      print(currentUser.email);
      loggedInUser = currentUser;

      setState(() {

      });
    }
  }

  Future<DocumentReference> addMessageInDB(message) {
    var db = Firestore.instance;
    return db
        .collection("messages")
        .add({"text": message, "sender": loggedInUser.email});
  }
}
