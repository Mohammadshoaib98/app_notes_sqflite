import 'package:app_notes_sqflite/sql_DB.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

class AddNote extends StatefulWidget {
  AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final GlobalKey<FormState> _key = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add note')),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(children: [
          Column(children: [
            Form(
              key: _key,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: title,
                    decoration:
                        const InputDecoration(hintText: 'enter your title'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: note,
                    decoration:
                        const InputDecoration(hintText: 'enter your note'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: color,
                    decoration:
                        const InputDecoration(hintText: 'enter your color'),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 25,
                    width: 250,
                    child: MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () async {
                        try {
                          int response = await sqlDb.insertData(
                             '''INSERT INTO 'Notes'("note","title","color") VALUES ("${note.text}","${title.text}","${color.text}")''');
                          print('*********response********');

                          if(response>0){
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Home(),),(route)=>false);
                          }
                          print(response);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text('Add Notes'),
                    ),
                  )
                ],
              ),
            )
          ]),
        ]),
      ),
    );
  }
}
