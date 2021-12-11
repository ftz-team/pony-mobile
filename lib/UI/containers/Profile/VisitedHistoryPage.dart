import 'package:cybergarden_app/UI/components/cards/AchivementCard.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorCard.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorUpdated.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/dateHelpers.dart';
import 'package:cybergarden_app/data/models/AchivementModel.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/repository/achivementsApi.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HitoryPage extends StatefulWidget{
  HitoryPageState createState() => HitoryPageState();
}

class HitoryPageState extends State<HitoryPage>{

  List<CollectorModel> collectors = [];

  init() async{
    var res = await loadHistory();
    this.setState(() {
      collectors = res;
    });
  }

  @override
  void initState(){
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = displayWidth(context);
    double height = displayHeight(context);
    return Scaffold(
      backgroundColor: UIColors.darkenBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor : UIColors.background,
        elevation: 0.0,
        title:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children : [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: new Icon(
                  Icons.arrow_back,
                  color : UIIconColors.active,
                ),
              ),

            ]
        ),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
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
                child: defaultHeader(
                  "Посещенные места",
                ),

              )
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.only(
                top: 20
              ),
                width : width,
                height : height,
                padding : EdgeInsets.symmetric(
                    horizontal: 18,

                ),
                child : ListView(
                  shrinkWrap: true,
                  children: [
                    for (var i in collectors) CollectorUpdated(collectorModel: i, date: dmy(i.visited_at!)+","+normalS(i.visited_at!),),
                    collectors.length == 0 ? plc() : SizedBox()
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}