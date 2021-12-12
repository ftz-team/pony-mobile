import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorCard.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/data/bloc/WashesBloc.dart';
import 'package:cybergarden_app/data/models/WashModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'WashPage.dart';
import 'WashPrice.dart';
import 'WashRaiting.dart';
import 'WashTag.dart';

Widget WashCard(WashModel wash, BuildContext context){
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          new CupertinoPageRoute(
              builder: (context) => WashPage(
                  wash:
                  wash)));
    },
    child: Container(
      decoration: BoxDecoration(
        color: UIColors.secondary,
        borderRadius: BorderRadius.all(
          Radius.circular(15)
        )
      ),
      child: Container(
        width: 350,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      child:
                      miniHeader(wash.name),
                      margin: EdgeInsets.only(bottom: 5),
                    ),
                  ],
                ),

              ],
            ),

            Row(
              children: [
                WashRaiting(wash.rating),
                SizedBox(
                  width: 5,
                ),
                WashPrice(wash.price_level),
              ],
            ),

            Container(height: 5,),
            CollectorAdress(
              adress: wash.address
            ),

            Container(
              height: 10,
            ),
            Wrap(
              children: [
                for (var a in wash.services) Padding(padding: EdgeInsets.only(right: 13, bottom: 10  ),child: WashTag(a['type_name']),) ,
              ],
            ),

            Container(
              height: 10,
            ),
            Container(
              width: 350,
              height: 85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(20))),
              child: CollectorImage(
                image_url: wash.image,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}