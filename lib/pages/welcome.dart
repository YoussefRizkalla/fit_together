import 'package:fit_together/auth/signup.dart';
import 'package:fit_together/auth/login.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget> [
          new Image(
            image: new AssetImage("assets/backgroundImg.jpg"),
            fit: BoxFit.cover
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(30), 
                child: new Text("Get Fit Together",
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  )
                ),
              ),
              new MaterialButton(
              height: 40,
              minWidth: 180,
              color: Colors.teal,
              splashColor: Colors.white,
              textColor: Colors.white,
              child: new Text('Login'),
              onPressed: navigateToSignIn
              ),
              new MaterialButton(
              height: 40,
              minWidth: 180,
              color: Colors.blue,
              splashColor: Colors.white,
              textColor: Colors.white,
              child: new Text('Sign up'),
              onPressed: navigateToSignUp
              )
            ],
          )
        ]
      ),
    );
  }

  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup(), fullscreenDialog: true));
  }
}
