import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../blok.dart';
import '../main_controller.dart';
import 'floor_widget.dart';

class MainWidget extends StatelessWidget {
  MainWidget({super.key});
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    var daireler = mainController.daireler;
    List<Widget> listDaireler = <Widget>[];

    for (Daire daire in daireler) {
      listDaireler.add(ListTile(
        title: Text(daire.key.toString()),
      ));
    }

    Set<int> katlar = {};

    daireler.forEach(
      (element) => katlar.add(element.bulunduguKat),
    );

    List<int> katlarList = katlar.toList();
    katlarList.sort();
    return Center(
      child: Container(
        color: Colors.lightBlueAccent.shade100,
        alignment: Alignment.center,
        child: daireler.isEmpty
            ? const Text('Kayıt yok.')
            : ListView.separated(
                itemCount: katlar.length,
                //TODO: Sıralı gelmiyor
                separatorBuilder: (_, index) => const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Container(
                        color: Colors.amber[100],
                        height: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Kat ${katlar.elementAt(index)}'),
                          ],
                        )),
                    title: FloorWidget(
                      floor: katlarList[index],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
