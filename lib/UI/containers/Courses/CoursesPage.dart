import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Обучение",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(),
    );
  }
}