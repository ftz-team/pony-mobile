import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget{
  LoadingScreenState createState()=> LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Загрузка"),
      ),
    );
  }
}
