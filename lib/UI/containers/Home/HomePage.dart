import 'dart:async';

import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorCard.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorUpdated.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/UI/containers/Filters/FiltersPage.dart';
import 'package:cybergarden_app/UI/containers/Home/HomeExtPage.dart';
import 'package:cybergarden_app/UI/containers/Wash/WashCard.dart';
import 'package:cybergarden_app/UI/containers/Wash/WashPage.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/bloc/NavigationBloc.dart';
import 'package:cybergarden_app/data/bloc/WashesBloc.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/models/WashModel.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<WashModel> washes = [];
  late StreamSubscription _subscription;

  @override
  void initState() {
    _subscription = washesBloc.washesList.listen((data) {
      this.setState(() {
        washes = data;
      });
    });
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => washesBloc.loadWashes());
  }

  @override
  Widget build(BuildContext context) {
    double height = displayHeight(context);
    double width = displayWidth(context);
    return Scaffold(

        backgroundColor: UIColors.darkenBackground,
        body: ListView(
          shrinkWrap: true,
          children: [
            Container(
              width: width,
              padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15
              ),
              decoration: BoxDecoration(
                  color: UIColors.background,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  defaultHeader(
                    "Wash",
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, new CupertinoPageRoute(builder: (context) => FiltersPage()));
                    },
                    child: Icon(
                      Icons.format_paint,
                      color: UIIconColors.active,
                    ),
                  )
                ],
              ),

            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: defaultHeader("Список автомоек"),
                  ),
                  plainText("Выбери автомойку по душе!", align: TextAlign.left),
                  Container(
                    height: 30,
                  ),
                  washes.length == 0
                      ? Container(
                    height: 36,
                    width: 24,
                    margin: EdgeInsets.only(right: 163, left: 163),
                    child: CircularProgressIndicator(
                      color: UIIconColors.active,
                    ),
                  )
                      : ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      for (var wash in washes)
                        Container(
                          child: WashCard(wash, context),
                          padding: EdgeInsets.only(
                            bottom: 20
                          ),
                        )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
