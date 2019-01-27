import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String photoURL;
  CircleImage(this.photoURL);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(photoURL),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(75.0)),
          boxShadow: [
            BoxShadow(blurRadius: 7.0, color: Colors.greenAccent)
      ]));
  }
}