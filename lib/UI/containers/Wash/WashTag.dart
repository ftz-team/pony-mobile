import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget WashTag(String label, {double padding = 0}){

  return Container(
    child: MiniGradientButton(
      child: Container(
        padding: EdgeInsets.all(padding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(440)),
              ),
              height: 15,
              width: 15,

            ),
            SizedBox(
              width: 5,
            ),
            plainText(label),

          ],
        ),
      ), onPressed: () {  }
    ),
  );

}