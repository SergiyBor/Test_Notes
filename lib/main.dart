import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:note_book/the_note_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(152, 32, 32, 33),
        body: SafeArea(
          child: NoteWidget(),
        ),
      ),
    );
  }
}
