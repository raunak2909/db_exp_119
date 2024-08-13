import 'package:db_exp_119/data/local/db_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBHelper myDb = DBHelper.getInstance();

  List<Map<String, dynamic>> allNotes = [];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  void getNotes()async{
    allNotes = await myDb.fetchAllNotes();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    //DBHelper myDB = DBHelper();


    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: allNotes.isNotEmpty ? ListView.builder(
        itemCount: allNotes.length,
          itemBuilder: (_, index){
        return ListTile(
          leading: Text('${allNotes[index][DBHelper.COLUMN_NOTE_SNO]}'),
          title: Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
          subtitle: Text(allNotes[index][DBHelper.COLUMN_NOTE_DESC]),
        );
      }) : Center(child: Text('No Notes yet!!'),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          bool check = await myDb.addNote(title: "New Note", desc: "Love what you do or do what you love.");
          if(check){
            getNotes();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
