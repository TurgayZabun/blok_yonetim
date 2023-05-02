import 'package:blok_yonetim/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../blok.dart';
import 'add_person.dart';
import 'edit_person.dart';

class PersonList extends StatelessWidget {
  // late Birey birey;

  final MainController mcont = Get.find();
  PersonList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Birey> bireyler = mcont.bireyler;

    return Center(
      child: Column(
        children: [
          Obx(
            () => Expanded(
              child: bireyler.isEmpty
                  ? const Center(child: Text('Kayıt yok.'))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        itemCount: bireyler.length,
                        itemBuilder: (context, index) {
                          return Expanded(
                            child: Card(
                              color: Colors.blue[50],
                              child: Row(children: [
                                Expanded(
                                  flex: 6,
                                  child: ListTile(
                                    title: Text('Daire : '
                                        '${bireyler[index].daire.toString()} || '
                                        '${bireyler[index].adi} '
                                        '${bireyler[index].soyadi}'),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: () => Get.to(
                                          EditPerson(birey: bireyler[index])),
                                      icon: const Icon(Icons.edit)),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: () => deletePersonDialog(bireyler[
                                          index]), // deleteAlert(bireyler[index]),
                                      icon: const Icon(Icons.delete)),
                                )
                              ]),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.to(const AddPerson()),
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
  }

  void deletePersonDialog(Birey birey) {
    Get.dialog(AlertDialog(
        title: const Text('Sil?'),
        content: Text(
            'Silmek istediğinize emin misiniz? Silinecek: ${birey.adi} ${birey.soyadi}'),
        actions: [
          ElevatedButton(
              onPressed: () {
                mcont.delPerson(birey);
                Get.back();
              },
              child: const Text('Sil')),
          TextButton(onPressed: () => Get.back(), child: const Text('İptal'))
        ]));
  }
}
