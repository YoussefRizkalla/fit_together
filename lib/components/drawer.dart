import 'package:firebase_auth/firebase_auth.dart';
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
              accountName: new Text("Test"),
              accountEmail: new Text('${user.email}'),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.cyan,
                child:new Text("Test"),
              ),
            ),
            new ListTile(
              title: new Text("Main Page"),
              trailing: new Icon(Icons.arrow_upward)
              ),
            new ListTile(
              title: new Text("Messaging"),
              trailing: new Icon(Icons.arrow_downward),
              onTap: ()=> Navigator.of(context).pushNamed("/movetomessaging")
            ),
            new Divider(),
            new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.close),
              onTap: ()=> Navigator.of(context).pop(),
              ),
          ],
        )
      );
  }
}