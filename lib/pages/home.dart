import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/components/drawer.dart';
import 'package:fit_together/pages/messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:async';
import 'dart:io' show Platform;

class Home extends StatelessWidget{
  const Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.green
      ),
      home: new HomePage(),
      routes: <String,WidgetBuilder>{
        "/movetomessaging":(BuildContext context) => new MessagingPage("Welcome to le asshole", user),
    }
    );
  }
}
Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS
        ? const FirebaseOptions(
            googleAppID: '1:624841009392:android:4d0d98fff1f06f77',
            gcmSenderID: '297855924061',
            databaseURL: 'fit-together-b972e.firebaseio.com',
          )
        : const FirebaseOptions(
            googleAppID: '1:624841009392:android:4d0d98fff1f06f77',
            apiKey: 'AIzaSyADf2plmenn7Y1ei-Xiz4vwj1lK4A6zFaA',
            databaseURL: 'fit-together-b972e.firebaseio.com',
          ),
  );
  runApp(MaterialApp(
    title: 'Players rn',
    home: HomePage(app: app),
  ));
}

class HomePage extends StatefulWidget {
  HomePage({this.app});
  final FirebaseApp app;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter;
  DatabaseReference _counterRef;
  DatabaseReference _messagesRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  bool _anchorToBottom = false;

  String _kTestKey = 'Hello';
  String _kTestValue = 'world!';
  DatabaseError _error;

  @override
  void initState() {
    super.initState();
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    // Demonstrates configuring the database directly
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _messagesRef = database.reference().child('messages');
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);
    _counterSubscription = _counterRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        _counter = event.snapshot.value ?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError error = o;
      setState(() {
        _error = error;
      });
    });
    _messagesSubscription =
        _messagesRef.limitToLast(10).onChildAdded.listen((Event event) {
      print('Child added: ${event.snapshot.value}');
    }, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }

  Future<void> _increment() async {
    // Increment counter in transaction.
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;
      return mutableData;
    });

    if (transactionResult.committed) {
      _messagesRef.push().set(<String, String>{
        _kTestKey: '$_kTestValue ${transactionResult.dataSnapshot.value}'
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Database Example'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Center(
              child: _error == null
                  ? Text(
                      'Button tapped $_counter time${_counter == 1 ? '' : 's'}.\n\n'
                          'This includes all devices, ever.',
                    )
                  : Text(
                      'Error retrieving button tap count:\n${_error.message}',
                    ),
            ),
          ),
          ListTile(
            leading: Checkbox(
              onChanged: (bool value) {
                setState(() {
                  _anchorToBottom = value;
                });
              },
              value: _anchorToBottom,
            ),
            title: const Text('Anchor to bottom'),
          ),
          Flexible(
            child: FirebaseAnimatedList(
              key: ValueKey<bool>(_anchorToBottom),
              query: _messagesRef,
              reverse: _anchorToBottom,
              sort: _anchorToBottom
                  ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
                  : null,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: Text("$index: ${snapshot.value.toString()}"),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
