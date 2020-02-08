import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final message;
  final sender;
  final isMe;

  MessageBubble({this.message, this.sender, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender),
          MaterialButton(
            isMe: isMe,
            message: message,
          ),
        ],
      ),
    );
  }
}

class MaterialButton extends StatelessWidget {
  final isMe;
  final message;

  MaterialButton({this.isMe, this.message});

  @override
  Widget build(BuildContext context) {
    final radius30 = Radius.circular(30.0);
    final radius0 = Radius.circular(0.0);

    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.only(
          topLeft: isMe ? radius30 : radius0,
          topRight: isMe ? radius0 : radius30,
          bottomLeft: radius30,
          bottomRight: radius30),
      color: isMe ? Colors.lightBlueAccent : Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Text(
          "$message",
          style: TextStyle(
              fontSize: 16, color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
