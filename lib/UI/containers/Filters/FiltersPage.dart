import 'package:cybergarden_app/UI/components/BottomSheets/CollectorBottomSheet.dart';
import 'package:cybergarden_app/UI/components/BottomSheets/SelectTimeBottomSheet.dart';
import 'package:cybergarden_app/UI/components/BottomSheets/SelectTimeSheet.dart';
import 'package:cybergarden_app/UI/components/BottomSheets/SelectTypesSheet.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorCard.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorUpdated.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/bloc/WashesBloc.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FiltersPage extends StatefulWidget{
  FiltersPageState createState()=> FiltersPageState();
}

class FiltersPageState extends State<FiltersPage>{
  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => washesBloc.updateFilters());
  }
  @override
  Widget build(BuildContext context) {

    double height = displayHeight(context);
    double width = displayWidth(context);

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
                    "Фильтры",
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
                    stream : washesBloc.activeFilters,
                    builder:  (context, AsyncSnapshot<Map> snapshot){


                      if (snapshot.data !=null && snapshot.hasData){
                        return ListView(
                          children: [
                            defaultHeader("Сортировка:"),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    plainText(WashesBloc.sortsHardCode[snapshot.data!['sort']]),
                                    InkWell(
                                      onTap: (){
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(125.0),
                                            ),
                                            builder: (context) {
                                              return SelectTimeBottomSheet(context);
                                            });
                                      },
                                      child: Icon(
                                        Icons.settings,
                                        color: UIIconColors.active,
                                        size: 32,
                                      ),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color : UIColors.gray,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            defaultHeader("Время:"),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: UIColors.gray,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: snapshot.data!['times'].length == 0 ? plainText("Любое время"): Column(
                                        children:[ for (var i in snapshot.data!['times']) Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(40))
                                                ),

                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              plainText(WashesBloc.timesHardCode[i])
                                            ],

                                          ),
                                        ),]
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        child: InkWell(
                                          onTap: (){
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(125.0),
                                                ),
                                                builder: (context) {
                                                  return SelectTimeSheet(context);
                                                });
                                          },
                                          child: Icon(
                                            Icons.add_road_sharp,
                                            color: UIIconColors.active,
                                            size: 32,
                                          ),
                                        ),
                                        alignment: Alignment.centerRight,
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            defaultHeader("Услуги:"),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: UIColors.gray,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: snapshot.data!['types'].length == 0 ? plainText("Любые услуги"): Column(
                                          children:[ for (var i in snapshot.data!['types']) Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 15,
                                                  width: 15,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.all(Radius.circular(40))
                                                  ),

                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                plainText(WashesBloc.typesHardCode[i])
                                              ],

                                            ),
                                          ),]
                                      ),
                                    ),
                                    Expanded(
                                        child: Align(
                                          child: InkWell(
                                            onTap: (){
                                              showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(125.0),
                                                  ),
                                                  builder: (context) {
                                                    return SelectTypeSheet(context);
                                                  });
                                            },
                                            child: Icon(
                                              Icons.add_road_sharp,
                                              color: UIIconColors.active,
                                              size: 32,
                                            ),
                                          ),
                                          alignment: Alignment.centerRight,
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
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