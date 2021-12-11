import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/bloc/NavigationBloc.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:flutter/material.dart';

class HomeExtPage extends StatelessWidget{
  CollectorModel collectorModel;
  HomeExtPage({required this.collectorModel});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : UIColors.background,
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
      body: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            CachedNetworkImage(
                imageUrl: collectorModel.photo
            ),
            Container(
              height: 20,
            ),
            defaultHeader(collectorModel.name),
            plainText(collectorModel.description,align: TextAlign.left),
            Container(
              height: 30,
            ),
            DefaultButton(
                child: Text("Перейти",
                  style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {

                  Navigator.pop(context);
                  navigationBloc.setTab(1);
                  collectorsBloc.addActive(collectorModel);

                }),
          ],
        ),
      )
    );
  }
}