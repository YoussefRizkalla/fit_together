import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_together/components/drawer.dart';
import 'package:fit_together/events/database_helper.dart';
import 'package:fit_together/events/event.dart';
import 'package:fit_together/events/event_details.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


class EventList extends StatefulWidget {
  final FirebaseUser user;
  EventList(this.user);
	@override
  State<StatefulWidget> createState() {

    return EventListState();
  }
}

class EventListState extends State<EventList> {

	DatabaseHelper databaseHelper = DatabaseHelper();
	List<Event> eventList;
	int count = 0;

	@override
  Widget build(BuildContext context) {

		if (eventList == null) {
			eventList = List<Event>();
			updateListView();
		}

    return Scaffold(

	    appBar: AppBar(
		    title: Text('Events Today'),
	    ),
      drawer: AppDrawer(widget.user),
	    body: geteventListView(),

	    floatingActionButton: FloatingActionButton(
		    onPressed: () {
		      navigateToDetail(Event('', '', 2), 'Add event');
		    },

		    tooltip: 'Add Event',

		    child: Icon(Icons.add),

	    ),
    );
  }

  ListView geteventListView() {

		TextStyle titleStyle = Theme.of(context).textTheme.subhead;

		return ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
				return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

						leading: CircleAvatar(
							backgroundColor: getPriorityColor(this.eventList[position].priority),
							child: getPriorityIcon(this.eventList[position].priority),
						),

						title: Text(this.eventList[position].title, style: titleStyle,),

						subtitle: Text(this.eventList[position].date),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, eventList[position]);
							},
						),


						onTap: () {
							navigateToDetail(this.eventList[position],'Edit Event');
						},

					),
				);
			},
		);
  }

  // Returns the priority color
	Color getPriorityColor(int priority) {
		switch (priority) {
			case 1:
				return Colors.red;
				break;
			case 2:
				return Colors.yellow;
				break;

			default:
				return Colors.yellow;
		}
	}

	// Returns the priority icon
	Icon getPriorityIcon(int priority) {
		switch (priority) {
			case 1:
				return Icon(Icons.play_arrow);
				break;
			case 2:
				return Icon(Icons.keyboard_arrow_right);
				break;

			default:
				return Icon(Icons.keyboard_arrow_right);
		}
	}

	void _delete(BuildContext context, Event event) async {

		int result = await databaseHelper.deleteevent(event.id);
		if (result != 0) {
			_showSnackBar(context, 'Event Removed');
			updateListView();
		}
	}

	void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

  void navigateToDetail(Event event, String title) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return EventDetail(event, title);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<Event>> eventListFuture = databaseHelper.geteventList();
			eventListFuture.then((eventList) {
				setState(() {
				  this.eventList = eventList;
				  this.count = eventList.length;
				});
			});
		});
  }
}






