import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../buttons.dart';

class CategoryCard extends StatelessWidget{

  String name;

  bool active;

  VoidCallback onPressed;


  CategoryCard({required String this.name, required bool this.active,required VoidCallback this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 10
      ),
      child: !active? SecondaryButton(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,

            ),
          ),
          onPressed: this.onPressed
      ):MiniGradientButton(
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,

            ),
          ),
          onPressed: this.onPressed
      ),
    );
  }

}

