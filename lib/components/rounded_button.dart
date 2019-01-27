import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String text;
  final MaterialPageRoute path;
  RoundedButton(this.color, this.text, this.path);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 95.0,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Colors.greenAccent,
        color: color,
        elevation: 7.0,
        child: GestureDetector(
          onTap: () {Navigator.push(context, path);},
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ));
  }
}