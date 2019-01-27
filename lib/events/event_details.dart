import 'dart:async';
import 'package:fit_together/events/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:fit_together/events/event.dart';
//import 'package:flutter_app/utils/database_helper.dart';
//import 'package:intl/intl.dart';

class EventDetail extends StatefulWidget {

	final String appBarTitle;
	final Event event;

	EventDetail(this.event, this.appBarTitle);

	@override
  State<StatefulWidget> createState() {

    return EventDetailState(this.event, this.appBarTitle);
  }
}

class EventDetailState extends State<EventDetail> {

	static var _priorities = ['High', 'Low'];

	DatabaseHelper helper = DatabaseHelper();

	String appBarTitle;
	Event event;

	TextEditingController titleController = TextEditingController();
	TextEditingController descriptionController = TextEditingController();

	EventDetailState(this.event, this.appBarTitle);

	@override
  Widget build(BuildContext context) {

		TextStyle textStyle = Theme.of(context).textTheme.title;

		titleController.text = event.title;
		descriptionController.text = event.description;

    return WillPopScope(

	    onWillPop: () {
	    	// Write some code to control things, when user press Back navigation button in device navigationBar
		    moveToLastScreen();
	    },

	    child: Scaffold(
	    appBar: AppBar(
		    title: Text(appBarTitle),
		    leading: IconButton(icon: Icon(
				    Icons.arrow_back),
				    onPressed: () {
		    	    // Write some code to control things, when user press back button in AppBar
		    	    moveToLastScreen();
				    }
		    ),
	    ),

	    body: Padding(
		    padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
		    child: ListView(
			    children: <Widget>[

			    	// First element
				    ListTile(
					    title: DropdownButton(
							    items: _priorities.map((String dropDownStringItem) {
							    	return DropdownMenuItem<String> (
									    value: dropDownStringItem,
									    child: Text(dropDownStringItem),
								    );
							    }).toList(),

							    style: textStyle,

							    value: getPriorityAsString(event.priority),

							    onChanged: (valueSelectedByUser) {
							    	setState(() {
							    	  debugPrint('User selected $valueSelectedByUser');
							    	  updatePriorityAsInt(valueSelectedByUser);
							    	});
							    }
					    ),
				    ),

				    // Second Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: titleController,
						    style: textStyle,
						    onChanged: (value) {
						    	debugPrint('Something changed in Title Text Field');
						    	updateTitle();
						    },
						    decoration: InputDecoration(
							    labelText: 'Title',
							    labelStyle: textStyle,
							    border: OutlineInputBorder(
								    borderRadius: BorderRadius.circular(5.0)
							    )
						    ),
					    ),
				    ),

				    // Third Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: descriptionController,
						    style: textStyle,
						    onChanged: (value) {
							    debugPrint('Something changed in Description Text Field');
							    updateDescription();
						    },
						    decoration: InputDecoration(
								    labelText: 'Description',
								    labelStyle: textStyle,
								    border: OutlineInputBorder(
										    borderRadius: BorderRadius.circular(5.0)
								    )
						    ),
					    ),
				    ),

				    // Fourth Element
				    Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: Row(
						    children: <Widget>[
						    	Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Save',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
									    	setState(() {
									    	  debugPrint("Save button clicked");
									    	  _save();
									    	});
									    },
								    ),
							    ),

							    Container(width: 5.0,),

							    Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Delete',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
										    setState(() {
											    debugPrint("Delete button clicked");
											    _delete();
										    });
									    },
								    ),
							    ),

						    ],
					    ),
				    ),

			    ],
		    ),
	    ),

    ));
  }

  void moveToLastScreen() {
		Navigator.pop(context, true);
  }

	// Convert the String priority in the form of integer before saving it to Database
	void updatePriorityAsInt(String value) {
		switch (value) {
			case 'High':
				event.priority = 1;
				break;
			case 'Low':
				event.priority = 2;
				break;
		}
	}

	// Convert int priority to String priority and display it to user in DropDown
	String getPriorityAsString(int value) {
		String priority;
		switch (value) {
			case 1:
				priority = _priorities[0];  // 'High'
				break;
			case 2:
				priority = _priorities[1];  // 'Low'
				break;
		}
		return priority;
	}

	// Update the title of event object
  void updateTitle(){
    event.title = titleController.text;
  }

	// Update the description of event object
	void updateDescription() {
		event.description = descriptionController.text;
	}

	// Save data to database
	void _save() async {

		moveToLastScreen();

		event.date = DateTime.now().toString();
		int result;
		if (event.id != null) {  // Case 1: Update operation
			result = await helper.updateevent(event);
		} else { // Case 2: Insert Operation
			result = await helper.insertevent(event);
		}

		if (result != 0) {  // Success
			_showAlertDialog('Status', 'event Saved Successfully');
		} else {  // Failure
			_showAlertDialog('Status', 'Problem Saving event');
		}

	}

	void _delete() async {

		moveToLastScreen();

		// Case 1: If user is trying to delete the NEW event i.e. he has come to
		// the detail page by pressing the FAB of eventList page.
		if (event.id == null) {
			_showAlertDialog('Status', 'No event was deleted');
			return;
		}

		// Case 2: User is trying to delete the old event that already has a valid ID.
		int result = await helper.deleteevent(event.id);
		if (result != 0) {
			_showAlertDialog('Status', 'event Deleted Successfully');
		} else {
			_showAlertDialog('Status', 'Error Occured while Deleting event');
		}
	}

	void _showAlertDialog(String title, String message) {

		AlertDialog alertDialog = AlertDialog(
			title: Text(title),
			content: Text(message),
		);
		showDialog(
				context: context,
				builder: (_) => alertDialog
		);
	}

}









