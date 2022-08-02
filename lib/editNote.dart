import 'package:app_notes_sqflite/sql_DB.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';

class EditNote extends StatefulWidget {
  final title;
  final note;
  final color;
  final id;

  EditNote({Key? key, this.title, this.note, this.color, this.id})
      : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final GlobalKey<FormState> _key = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  SqlDb sqlDb = SqlDb();

  @override
  void initState() {
    title.text = widget.title;
    note.text = widget.note;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Note')),
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 25,
                    width: 250,
                    child: MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () async {
                        try {
                          int response = await sqlDb.updateData('''
                              UPDATE Notes SET
                              note="${note.text}",
                              title="${title.text}",
                              color="${color.text}"
                              WHERE id = ${widget.id}
                              ''');
                          print('*********response********'+'$response');
                          if (response > 0) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),(route) => false);
                          }
                          print(response);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text('Edit Note'),
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
