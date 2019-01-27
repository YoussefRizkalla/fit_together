import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/components/circle_image.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final FirebaseUser user;
  EditProfilePage(this.user);
  @override
  _EditProfilePage createState() => _EditProfilePage(user);
}

class _EditProfilePage extends State<EditProfilePage> {
  FirebaseUser user;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
  _EditProfilePage(this.user);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Profile"),
      ),
      body: new Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Stack(
              alignment: const Alignment(0.5, 0.5),
              children: <Widget> [
              Padding(padding: const EdgeInsets.all(16), 
                child: CircleImage('https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg')),
              Container(  
                decoration: new BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: IconButton(icon: Icon(Icons.edit),
                color: Colors.white, tooltip: 'Edit Profile Picture', onPressed: (){},),
              ),
              ]
            ),
            Container(width:200, 
            child: TextFormField(
              validator: (input) {
                if(input.isEmpty) {
                  return 'Nickname field is empty';
                }
              },
              decoration: InputDecoration(
                labelText: 'Nickname'
              ),
              onSaved: (input) => _name = input,
            ))
        ])
      ),
    );
  }

  void updateName() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        var userInfo = new UserUpdateInfo();
        userInfo.displayName = _name;
        //user.updateProfile(userInfo);
      }catch(e){
        print(e.message);
      }
    }
  }
}
