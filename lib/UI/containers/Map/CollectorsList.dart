import 'package:cybergarden_app/UI/components/cards/CollectorCard.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorUpdated.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:flutter/material.dart';

class CollectorsList extends StatefulWidget{
  CollectorsListState createState()=> CollectorsListState();
}

class CollectorsListState extends State<CollectorsList>{
  @override
  Widget build(BuildContext context) {
    double height = displayHeight(context);
    double width = displayWidth(context);
    collectorsBloc.loadCollectors();
    return Scaffold(
      backgroundColor: UIColors.darkenBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor : UIColors.background,
        elevation: 0.0,
        title:Container(

          child: Column(
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
                "Пункты приема",
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
                child : StreamBuilder(
                  stream : collectorsBloc.collectors,
                  builder: (context, AsyncSnapshot<List<CollectorModel>> snapshot){
                    if (snapshot.data !=null && snapshot.hasData){
                      return ListView(children: [
                        for (var i in snapshot.data!) Container(
                          margin: EdgeInsets.only(
                            bottom: height*0.03
                          ),
                          child: CollectorUpdated(collectorModel: i,),
                        )
                      ],);
                    }else{
                      return Center(

                        child: Container(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: UIIconColors.active,
                          ),
                        ),
                      );
                    }
                  },
                )
            ),
          )
        ],
      )
    );
  }
}