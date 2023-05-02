import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../blok.dart';
import '../main_controller.dart';
import 'floor_widget.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
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

    return Container(
      color: Colors.lightBlueAccent.shade100,
      child: ListView.separated(
        itemCount: katlar.last - katlar.first + 2,
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
                    Text('Kat ${(index + katlar.first).toString()}'),
                  ],
                )),
            title: FloorWidget(
              floor: index + katlar.first,
            ),
          );
        },
      ),
    );
  }
}
