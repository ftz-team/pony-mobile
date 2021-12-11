import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultHeader(String text,{FontWeight fontWeight = FontWeight.bold, Color color = Colors.white, TextAlign textAlign = TextAlign.left} ){
  return Text(
    text,
    style: TextStyle(
        color:  color,
        fontSize: 24,
        fontWeight: fontWeight
    ),
      textAlign :textAlign
  );
}

Widget miniHeader(String text,{TextAlign align = TextAlign.center}){
  return Text(
    text,
    textAlign: align,
    style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 22
    ),
  );
}

Widget semiHeader(String text,{TextAlign align = TextAlign.center}){
  return Text(
    text,
    textAlign: align,
    style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 18
    ),
  );
}

Widget plainText(String text, {TextAlign align = TextAlign.center}){
  return Text(
    text,
    textAlign: align,
    style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14
    ),

  );
}

Widget subHeader(String text){
  return Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400
    ),
  );
}