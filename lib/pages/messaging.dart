import 'package:flutter/material.dart';
class MessagingPage extends StatelessWidget{
  final String title;
  MessagingPage(this.title);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title)
      ),
      body:new Center(
        child:new Text(title),
      )
    );
  }
}
