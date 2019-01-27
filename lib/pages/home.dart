import 'package:fit_together/pages/messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//void main ()=> runApp(new Home());
class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.lime
      ),
      home:new HomePage(),
      routes: <String,WidgetBuilder>{
        "/movetomessaging":(BuildContext context) => new MessagingPage("Welcome to le asshole"),
    }
    );
  }
}

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Yes"),
        elevation: defaultTargetPlatform ==TargetPlatform.android ? 5.0:0.0,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>
          [
            new UserAccountsDrawerHeader(
              accountName: new Text("Test"),
              accountEmail: new Text("Test@gmail.com"),
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
      ),
      body: new Container(
        child: new Center(
          child: new Text("Home Page")

        )
      )
    );
  }
}
