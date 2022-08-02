import 'package:app_notes_sqflite/editNote.dart';
import 'package:app_notes_sqflite/sql_DB.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  List notes = [];
  bool isLoading = true;

  Future readData() async {
    List<Map> response = await sqlDb.readData('SELECT * FROM Notes');
    notes.addAll(response);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed('addNote');
          }),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                /*  MaterialButton(
            onPressed: () async {
             await sqlDb.ResetDatabase();
            },
            child: const Text('Reset Database'),
          ),*/
                ListView.builder(
                    itemCount: notes.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                            title: Text("${notes[index]['title']}"),
                            subtitle: Text("${notes[index]['note']}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      int response = await sqlDb.deleteData(
                                          "delete from Notes where id='${notes[index]['id']}' ");
                                      if (response > 0) {
                                        setState(() {
                                          notes.removeWhere((element) =>
                                              element['id'] ==
                                              notes[index]['id']);
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => EditNote(
                                            id: notes[index]['id'],
                                            title: notes[index]['note'],
                                            note: notes[index]['title'],
                                            color: notes[index]['color'],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      color: Colors.blue,
                                    )),
                              ],
                            )),
                      );
                    }),
              ],
            ),
    );
  }
}

//SELECT
//INSERT
//UPDATE
//DELETE