import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/components/circle_image.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer(this.user);
  final FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: new ListView(
          children: <Widget>
          [
            new UserAccountsDrawerHeader(
              accountName: new Text("Tom Cruise"),
              accountEmail: new Text('${user.email}'),
              currentAccountPicture: new CircleImage('https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg')
            ),
            new ListTile(
              title: new Text("Home"),
              leading: new Icon(Icons.home),
              onTap: ()=> Navigator.of(context).pushNamed("/movetohome")
              ),
            new ListTile(
              title: new Text("Profile"),
              leading: new Icon(Icons.person),
              onTap: ()=> Navigator.of(context).pushNamed("/movetoprofile")
            ),
            new ListTile(
              title: new Text("Manage Events"),
              leading: new Icon(Icons.event),
              onTap: ()=> Navigator.of(context).pushNamed("/movetoevents")
            ),
            new ListTile(
              title: new Text("Friends"),
              leading: new Icon(Icons.people),
              onTap: ()=> Navigator.of(context).pushNamed("/movetofriends")
            ),
            new ListTile(
              title: new Text("Messaging"),
              leading: new Icon(Icons.message),
              onTap: ()=> Navigator.of(context).pushNamed("/movetomessaging")
            ),
            new Divider(),
            new ListTile(
              title: new Text("Settings"),
              leading: new Icon(Icons.settings),
            ),
            new ListTile(
              title: new Text("Logout"),
              leading: new Icon(Icons.power_settings_new),
            ),
            new ListTile(
              title: new Text("Close Drawer"),
              leading: new Icon(Icons.close),
              onTap: ()=> Navigator.of(context).pop(),
              ),
          ],
        )
      );
  }
}