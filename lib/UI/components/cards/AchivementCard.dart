import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/models/AchivementModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CollectorCard.dart';

class AchivementCard extends StatelessWidget{

  AchivementModel achivement ;

  AchivementCard({required this.achivement});

  @override
  Widget build(BuildContext context) {
    double width = displayWidth(context);
    return Container(
      child: UnicornOutlineButton(
        gradient: UIGradients.Main,
        strokeWidth: 1,
        radius: 18,
        onPressed: (){},
        child: Container(
          width: width*0.87,

          padding: EdgeInsets.only(
              top: 28,
              right: 25,
              bottom: 25,
              left: 25
          ),
          child: Column(
            children: [
              Container(
                width: 70,
                height: 70,
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: achivement.photo,
                  placeholder: (context, url)=>plc(),
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 15
                  ),
                  child: miniHeader(achivement.header)
              ),
              plainText(achivement.description)
            ],
          ),
        ),
      ),
      margin: EdgeInsets.only(
        bottom: 25
      ),
    );
  }
}