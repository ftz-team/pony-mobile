import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget WashPrice(int price){
  return Row(
    children: [
      for (int i = 0; i < price; i++) Text("₽", style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 14
      ),),
      for (int i = price; i < 3; i++) Text("₽", style: TextStyle(
        color: Color(0xffA8A8A8),
        fontWeight: FontWeight.w600,
          fontSize: 14
      ),)
    ],
  );
}