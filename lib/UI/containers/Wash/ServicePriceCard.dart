import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/data/bloc/WashesBloc.dart';
import 'package:flutter/material.dart';

import 'WashTag.dart';

Widget ServicePriceCard(dynamic service){
    
  return Stack(
    children: [
      UnicornOutlineButton(strokeWidth: 1, radius: 20, gradient: UIGradients.Main, child: Container(
        child: Row(
          children: [
            WashTag(service['type_name']),
            Container(width: 30,),
            Text(service['price'].toString()+"₽",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600
              ),
            ),
            Container(width: 15,),
          ],
        ),
      ), onPressed: (){}),
      WashTag(service['type_name'], padding: 8)
    ],
  );
    
}