
import 'package:fit_together/events/event.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

	String eventTable = 'event_table';
	String colId = 'id';
	String colTitle = 'title';
	String colDescription = 'description';
	String colPriority = 'priority';
	String colDate = 'date';

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'events.db';

		// Open/create the database at a given path
		var eventsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return eventsDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $eventTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
				'$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
	}

	// Fetch Operation: Get all event objects from database
	Future<List<Map<String, dynamic>>> geteventMapList() async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $eventTable order by $colPriority ASC');
		var result = await db.query(eventTable, orderBy: '$colPriority ASC');
		return result;
	}

	// Insert Operation: Insert a event object to database
	Future<int> insertevent(Event event) async {
		Database db = await this.database;
		var result = await db.insert(eventTable, event.toMap());
		return result;
	}

	// Update Operation: Update a event object and save it to database
	Future<int> updateevent(Event event) async {
		var db = await this.database;
		var result = await db.update(eventTable, event.toMap(), where: '$colId = ?', whereArgs: [event.id]);
		return result;
	}

	// Delete Operation: Delete a event object from database
	Future<int> deleteevent(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $eventTable WHERE $colId = $id');
		return result;
	}

	// Get number of event objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $eventTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'event List' [ List<event> ]
	Future<List<Event>> geteventList() async {

		var eventMapList = await geteventMapList(); // Get 'Map List' from database
		int count = eventMapList.length;         // Count the number of map entries in db table

		List<Event> eventList = List<Event>();
		// For loop to create a 'event List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			eventList.add(Event.fromMapObject(eventMapList[i]));
		}

		return eventList;
	}

}






