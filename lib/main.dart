import 'package:app_notes_sqflite/addNote.dart';
import 'package:flutter/material.dart';

import 'editNote.dart';
import 'homePage.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sqflite Course',
      home: Home(),
      routes: {
        'home':(context) => const Home(),
        'addNote':(context) => AddNote(),
        'editNote':(context)=> EditNote(),
      },
    );
  }
}
