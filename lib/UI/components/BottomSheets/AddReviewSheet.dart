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
import 'package:cybergarden_app/data/repository/washesApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Review.dart';
import '../cards/CollectorCard.dart';
import '../buttons.dart';

Widget AddReviewSheet(BuildContext context, int wash) {
  double height = displayHeight(context);
  double width = displayWidth(context);
  final ReviewController = TextEditingController();
  return Container(

    child: ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: height * 0.5
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
                    defaultHeader("Добавление отзыва", textAlign: TextAlign.left),

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    for (int i = 0; i < 3; i++)  CachedNetworkImage(imageUrl: "https://www.pngall.com/wp-content/uploads/9/Golden-Star-PNG-Image-File.png", height: 40, width: 40,),
                    for (var i = 3; i < 5; i++)  CachedNetworkImage(imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Star_empty.svg/471px-Star_empty.svg.png", height: 40, width: 40,),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ReviewController,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: width*0.01,
                    ),
                    hintText: "Текст отзыва",
                    hintStyle:
                    TextStyle(color: UITextColors.darked),
                  ),
                  style: TextStyle(
                      color: Colors. white,
                      fontSize: 18
                  ),
 // Only numbers can be entered
                  cursorColor: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),                SizedBox(
                  height: 10,
                ),
                Container(
                  width: width,
                  child: DefaultButton(
                      child: Text("Отправить",
                        style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        sendReview(
                          wash,
                            3,
                            ReviewController.value.text
                        );
                        Navigator.pop(context);
                        _showMyDialog(context);
                      }),
                ),
                SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),
      ),
    ),
  );



}

Future<void> _showMyDialog( context) async {
  Navigator.pop(context);
  return showDialog<void>(
    context: context, // user must tap button!
    builder: (BuildContext context) {
      return new AlertDialog(
        backgroundColor: UIColors.background,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        content:  Container(
          height: 170,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Column(
            children: [
              defaultHeader("Спасибо!"),
              SizedBox(
                height:20,
              ),
              semiHeader("Отзыв будет достпен другим пользователям и руководителю мойки.")
            ],
          ),
        ),
      );

    },
  );
}