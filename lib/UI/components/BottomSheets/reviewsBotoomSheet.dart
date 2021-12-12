import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybergarden_app/UI/components/cards/AchivementCard.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/UI/containers/Wash/WashPage.dart';
import 'package:cybergarden_app/data/bloc/CheckooutBloc.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/bloc/NavigationBloc.dart';
import 'package:cybergarden_app/data/bloc/WashesBloc.dart';
import 'package:cybergarden_app/data/models/AchivementModel.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/models/WashModel.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Review.dart';
import '../cards/CollectorCard.dart';
import '../buttons.dart';
import 'AddReviewSheet.dart';

Widget ReviewsBottomSheet(BuildContext context, dynamic reviews, int wash) {
  double height = displayHeight(context);
    return Container(

    child: ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: height * 0.8
      ),
      child: SingleChildScrollView(
        child: new Container(
          padding: EdgeInsets.only(top: 23, left: 15, right: 15),
          decoration: BoxDecoration(
              color: UIColors.background,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0))),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    defaultHeader("Отзывы", textAlign: TextAlign.left),
                    miniHeader("4.9"),

                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                DefaultButton(child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: plainText("Добавить отзыв"),
                ), onPressed: (){
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(125.0),
                      ),
                      builder: (context) {
                        return AddReviewSheet(context, wash);
                      });
                },paddingVert: 4),
                SizedBox(
                  height: 10,
                ),
                for (var e in reviews) Review(e)
              ],
            ),
          ),
        ),
      ),
    ),
  );



}


