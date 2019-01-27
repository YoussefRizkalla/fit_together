import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/pages/home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sign In"),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: new Form(key: _formKey, child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            new Text("Please enter your email and password correctly.",
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )
            ),
            new Padding(
            padding: const EdgeInsets.all(20), 
            child: new TextFormField(
              validator: (input) {
                if (input.isEmpty) {
                  return 'Provide an email';
                }
              },
              decoration: new InputDecoration(labelText: "Enter Email", filled: true),
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              onSaved: (input) => _email = input,
            ),),
            new Padding(
            padding: const EdgeInsets.all(20), 
            child: new TextFormField(
              validator: (input) {
                if(input.length < 6){
                  return 'Longer password please';
                }
              },
              decoration: new InputDecoration(labelText: "Enter Password", filled: true),
              autofocus: true,
              obscureText: true,
              onSaved: (input) => _password = input,
              keyboardType: TextInputType.text,
            ),),
            new MaterialButton(
              height: 40,
              minWidth: 180,
              color: Colors.teal,
              splashColor: Colors.white,
              textColor: Colors.white,
              child: new Text('Login'),
              onPressed: signIn,
            ),
          ],)
        ],
      ),)
      
    );
  }
  void signIn() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user)));
      }catch(e){
        print(e.message);
      }
    }
  }
}
