import 'package:blok_yonetim/main_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'flat_widget.dart';

class FloorWidget extends StatelessWidget {
  final int floor;

  const FloorWidget({super.key, required this.floor});

  @override
  Widget build(BuildContext context) {
    MainController mcont = Get.find();

    List<int> daireNumaralari = <int>[];

    mcont.daireler.where((p0) => p0.bulunduguKat == floor).forEach((element) {
      daireNumaralari.add(element.daireNo);
    });

    daireNumaralari.sort();

    List<FlatWidget> dairelerWidget = <FlatWidget>[];

    for (int i = daireNumaralari.first; i <= daireNumaralari.last; i++) {
      dairelerWidget.add(FlatWidget(
          keyHouse: mcont.daireler
              .firstWhere((element) => element.daireNo == i)
              .key));
    }

    return Row(
      children: dairelerWidget,
    );
  }
}
