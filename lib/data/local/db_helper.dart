import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{

  /// singleton instance
  DBHelper._();
  static DBHelper getInstance() => DBHelper._();

  /// global variable of my DB
  Database? mDB;
  static final String TABLE_NOTE = "note";
  static final String COLUMN_NOTE_SNO = "s_no";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DESC = "desc";

  Future<Database> getDB() async{

    mDB ??= await openDB();
    return mDB!;

    /*if(mDB!=null){
      return mDB!;
    } else {
      /// openDB
      mDB = await openDB();
      return mDB!;
    }*/

  }


  /// open db create db
  Future<Database> openDB() async{

    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "noteDB.db");


    return await openDatabase(dbPath, onCreate: (db, version){

      /// create all tables here
      db.execute("create table $TABLE_NOTE ( $COLUMN_NOTE_SNO integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text )");
      //
      //
      //
      //

    }, version: 1);

  }


  ///queries
  Future<bool> addNote({required String title, required String desc}) async{

    var mDB = await getDB();
    int rowsEffected = await mDB.insert(TABLE_NOTE, {
      COLUMN_NOTE_TITLE : title,
      COLUMN_NOTE_DESC : desc
    });

    return rowsEffected>0;

  }

  Future<List<Map<String, dynamic>>> fetchAllNotes() async{
    var mDB = await getDB();

    return await mDB.query(TABLE_NOTE);
  }

}