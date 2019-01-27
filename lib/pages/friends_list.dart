import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/components/drawer.dart';
import 'package:fit_together/components/friend.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FriendsListPage extends StatefulWidget {
  final FirebaseUser user;
  FriendsListPage(this.user);

  @override
  _FriendsListPageState createState() => new _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  List<Friend> _friends = [];

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    http.Response response =
        await http.get('https://randomuser.me/api/?results=15');

    setState(() {
      _friends = Friend.allFromResponse(response.body);
    });
  }

  Widget _buildFriendListTile(BuildContext context, int index) {
    var friend = _friends[index];

    return new ListTile(
      leading: new Hero(
        tag: index,
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(friend.avatar),
        ),
      ),
      title: new Text(friend.name),
      subtitle: new Text(friend.email),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_friends.isEmpty) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView.builder(
        itemCount: _friends.length,
        itemBuilder: _buildFriendListTile,
      );
    }

    return new Scaffold(
      appBar: new AppBar(title: new Text('Friends')),
      drawer: AppDrawer(widget.user),
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.add), ),
      body: content,
    );
  }
}
