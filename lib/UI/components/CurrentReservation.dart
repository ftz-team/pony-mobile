import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/models/WashModel.dart';
import 'package:flutter/material.dart';

import 'buttons.dart';

//TODO : change dynamic to MashModel
Widget CurrentReservation(dynamic wash, BuildContext context){
  double width = displayWidth(context);
  return Container(
    width: width*0.9,
    padding: EdgeInsets.all(
      15
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            plainText("17:35"),
            SizedBox(height: 5,),
            semiHeader("Автомойка “Хасан+”"),
            SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultButton(onPressed: () {
                  MapUtils.openMap(wash.point.lat, wash.point.long);
                },paddingVert:7, child: Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: plainText("Маршрут"),)),
                SizedBox(width: 10,),
                plainText("Отменить")
              ],
            )
          ],
        ),
        Container(
          height: 67,
          width: 67,
          child: CachedNetworkImage(
            imageUrl: "https://www.kaspersky.ru/content/ru-ru/images/repository/isc/2020/9910/a-guide-to-qr-codes-and-how-to-scan-qr-codes-2.png",
            height: 67,
            width: 67,
          ),
        ),
      ],
    ),
  );
}