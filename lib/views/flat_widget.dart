import 'package:blok_yonetim/main_controller.dart';
import 'package:blok_yonetim/views/popup_list_persons_in_flat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlatWidget extends StatelessWidget {
  final String keyHouse;

  const FlatWidget({super.key, required this.keyHouse});

  @override
  Widget build(BuildContext context) {
    MainController mcont = Get.find();

    return Expanded(
      child: InkWell(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              children: [
                Text(
                    '${mcont.getHouse(keyHouse).bulunduguBlok} ${mcont.getHouse(keyHouse).daireNo.toString()}')
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(mcont
                        .livingInFlat(mcont.getHouse(keyHouse).daireNo)
                        .toString())
                  ],
                ),
                Row(
                  children: const [Text('0')],
                ),
              ],
            )
          ]),
        ),
        onTap: () => {
          Get.dialog(PopListPersonsInFlat(
            daireNo: mcont.getHouse(keyHouse).daireNo,
          ))
        },
      ),
    );
  }
}
