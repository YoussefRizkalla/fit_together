import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/components/drawer.dart';
import 'package:fit_together/pages/messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.green
      ),
      home:new HomePage(user),
      routes: <String,WidgetBuilder>{
        "/movetomessaging":(BuildContext context) => new MessagingPage("Welcome to le asshole", user),
    }
    );
  }
}

class HomePage extends StatelessWidget{
  const HomePage(this.user);
  final FirebaseUser user;
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Yes"),
        elevation: defaultTargetPlatform ==TargetPlatform.android ? 5.0:0.0,
      ),
      drawer: AppDrawer(user),
      body: new Container(
        child: new Center(
          child: new Text("Home Page")

        )
      )
    );
  }
}
