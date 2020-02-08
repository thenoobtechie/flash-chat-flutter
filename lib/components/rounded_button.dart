import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedCornersButton extends StatelessWidget {

  final String title;
  final Color color;
  final Function onPressed;
  RoundedCornersButton({this.title, this.color, @required this.onPressed});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
