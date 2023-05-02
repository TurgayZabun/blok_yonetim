import 'package:blok_yonetim/main_controller.dart';
import 'package:blok_yonetim/views/popup_list_persons_in_flat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlatWidget extends StatelessWidget {
  final String keyHouse;
  final MainController mcont = Get.find();

  FlatWidget({super.key, required this.keyHouse});

  @override
  Widget build(BuildContext context) {
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
            Obx(
              () => Column(
                children: [
                  Text(mcont
                      .livingInFlat(mcont.getHouse(keyHouse).daireNo)
                      .toString()),
                  Container(
                    decoration: BoxDecoration(
                      color: mcont.livingInFlat(
                                  mcont.getHouse(keyHouse).daireNo) ==
                              mcont.safePersonInFlat(
                                  mcont.getHouse(keyHouse).daireNo)
                          ? Colors.transparent
                          : Colors.red,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    // color:
                    //     mcont.livingInFlat(mcont.getHouse(keyHouse).daireNo) ==
                    //             mcont.safePersonInFlat(
                    //                 mcont.getHouse(keyHouse).daireNo)
                    //         ? Colors.transparent
                    //         : Colors.red,
                    child: Text(mcont
                        .safePersonInFlat(mcont.getHouse(keyHouse).daireNo)
                        .toString()),
                  ),
                ],
              ),
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
