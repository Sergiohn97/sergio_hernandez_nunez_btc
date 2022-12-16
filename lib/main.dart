import 'package:flutter/material.dart';
import 'package:sergio_hernandez_nunez_btc/addOrdre_vista.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter examen',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home: const AddOrdre(),
    );
  }
}