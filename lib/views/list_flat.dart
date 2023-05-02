import 'package:blok_yonetim/blok.dart';
import 'package:blok_yonetim/main_controller.dart';
import 'package:blok_yonetim/views/add_house.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'edit_house.dart';

class HouseList extends StatelessWidget {
  const HouseList({super.key});

  @override
  Widget build(BuildContext context) {
    MainController mcont = Get.find();

    return Center(
      child: Column(
        children: [
          Obx(
            () => Expanded(
              child: mcont.daireler.isEmpty
                  ? const Text('Kayıt yok.')
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: mcont.daireler.length,
                          itemBuilder: (context, index) {
                            return Card(
                              shadowColor: Colors.amber,
                              color: Colors.blue[50],
                              //margin: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                          'Kat: ${mcont.daireler[index].bulunduguKat.toString()} '
                                          ' Daire: ${mcont.daireler[index].daireNo.toString()}'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        onPressed: () => Get.to(EditHouse(
                                              daireNo:
                                                  mcont.daireler[index].daireNo,
                                            )),
                                        //editHousePop(daireler[index].daireNo),
                                        icon: const Icon(Icons.edit)),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: IconButton(
                                        onPressed: () => deleteHouseDialog(
                                            mcont.daireler[index]),
                                        icon: const Icon(Icons.delete)),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.to(const AddHouse()),
            child: const Text('Ekle'),
          )
        ],
      ),
    );
  }

  void deleteHouseDialog(Daire daire) {
    Get.dialog(AlertDialog(
        title: const Text('Sil?'),
        content: Text(
            'Silmek istediğinize emin misiniz? Silinecek daire: ${daire.daireNo}'),
        actions: [
          ElevatedButton(
              onPressed: () {
                MainController mcont = Get.find();
                mcont.delHouse(daire);
                Get.back();
              },
              child: const Text('Sil')),
          TextButton(onPressed: () => Get.back(), child: const Text('İptal'))
        ]));
  }
}
