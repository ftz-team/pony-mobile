import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:flutter/cupertino.dart';

class CollectorMarket extends StatelessWidget{

  CollectorModel collector;
  bool active;

  CollectorMarket({
    required this.collector,
    required this.active
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: active ? UIIconColors.active : UIColors.background,
        borderRadius: BorderRadius.all(Radius.circular(70))
      ),
      padding: EdgeInsets.only(
        left: 17,
        top: 4,
        bottom: 4,
        right: 6
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(collector.name)
        ],
      ),
    );
  }
}