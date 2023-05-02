import 'package:blok_yonetim/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../blok.dart';
import 'add_person.dart';
import 'edit_person.dart';

class PersonList extends StatelessWidget {
  late Birey birey;

  @override
  Widget build(BuildContext context) {
    MainController mcont = Get.find();

    List<Birey> bireyler = mcont.bireyler;

    return Column(children: [
      Expanded(
        flex: 13,
        child: bireyler.isEmpty
            ? const Center(child: Text('Kişi yok.'))
            : Obx(
                () => ListView.separated(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: bireyler.length,
                  itemBuilder: (context, index) {
                    birey = bireyler[index];
                    return Expanded(
                      child: Card(
                        color: Colors.blue[50],
                        child: Row(children: [
                          Expanded(
                            flex: 6,
                            child: ListTile(
                              title: Text(
                                  'Daire : ${birey.daire.toString()} || ${birey.adi} ${birey.soyadi}'),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () =>
                                    Get.to(EditPerson(birey: bireyler[index])),
                                icon: const Icon(Icons.edit)),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () => deletePersonDialog(
                                    birey), // deleteAlert(bireyler[index]),
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
      Expanded(
        flex: 1,
        child: ElevatedButton(
          onPressed: () => Get.to(const AddPerson()),
          child: const Text('Ekle'),
        ),
      ),
    ]);
  }

  void deletePersonDialog(Birey birey) {
    Get.dialog(AlertDialog(
        title: const Text('Sil?'),
        content: Text(
            'Silmek istediğinize emin misiniz? Silinecek: ${birey.adi} ${birey.soyadi}'),
        actions: [
          ElevatedButton(
              onPressed: () {
                MainController mcont = Get.find();

                mcont.delPerson(birey);
                Get.back();
              },
              child: const Text('Sil')),
          TextButton(onPressed: () => Get.back(), child: const Text('İptal'))
        ]));
  }
}
