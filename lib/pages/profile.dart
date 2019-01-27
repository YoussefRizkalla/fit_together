import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/components/drawer.dart';
import 'package:fit_together/pages/edit_profile.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final FirebaseUser user;
  ProfilePage(this.user);
  _ProfilePageState createState() => _ProfilePageState(user);
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseUser user;
  _ProfilePageState(this.user);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('My Profile'),
        ),
        drawer: AppDrawer(user),
        body: new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.black.withOpacity(0.8)),
          clipper: GetClipper(),
        ),
        Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.greenAccent)
                        ])),
                SizedBox(height: 50.0),
                Text(
                  'Tom Cruise',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'tomcruise@gmail.ca'
                ),
                SizedBox(height: 25.0),
                Container(
                    height: 30.0,
                    width: 95.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Colors.green,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(), fullscreenDialog: true));},
                        child: Center(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                    )),
                    SizedBox(height: 25.0),
              ],
            ))
      ],
    ));
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
