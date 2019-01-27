import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/components/drawer.dart';
import 'package:flutter/material.dart';
class MessagingPage extends StatelessWidget{
  final String title;
  final FirebaseUser user;
  MessagingPage(this.title, this.user);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title)
      ),
      drawer: AppDrawer(user),
      body:new Center(
        child:new Text(title),
      )
    );
  }
}
