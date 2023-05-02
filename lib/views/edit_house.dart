import 'package:blok_yonetim/blok.dart';
import 'package:blok_yonetim/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';

class EditHouse extends StatefulWidget {
  final int daireNo;

  const EditHouse({super.key, required this.daireNo});

  @override
  State<EditHouse> createState() => _EditHouseState();
}

class _EditHouseState extends State<EditHouse> {
  final _key = GlobalKey<FormState>();

  final MainController mcont = Get.find();

  final TextEditingController _bulunduguKat = TextEditingController();
  final TextEditingController _daireNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Daire daire = mcont.daireler
        .toList()
        .where((element) => element.daireNo == widget.daireNo)
        .first;

    _bulunduguKat.text = daire.bulunduguKat.toString();
    _daireNo.text = daire.daireNo.toString();

    return Scaffold(
      appBar: AppBar(title: const Text('Daire Düzenle')),
      body: Center(
        child: Form(
          key: _key,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  validator: (value) =>
                      value == '' ? 'Daire no boş olamaz' : null,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Daire No'),
                    border: OutlineInputBorder(),
                    hintText: 'Daire numarası',
                  ),
                  controller: _daireNo),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  validator: (value) => value == '' ? 'Kat boş olamaz' : null,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Bulunduğu Kat'),
                    border: OutlineInputBorder(),
                    hintText: 'Bulunduğu kat',
                  ),
                  controller: _bulunduguKat),
            ),
            //NumberPicker(          minValue: 1,          maxValue: 10,          value: 1,          onChanged: (_) {},        ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      daire.bulunduguKat = int.parse(_bulunduguKat.text);
                      daire.daireNo = int.parse(_daireNo.text);

                      mcont.saveHouse(daire);
                      //daire.save();
                      Get.back();
                    } else {
                      Get.snackbar('Hata', 'Eksik bilgileri tamamlamalısınız',
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  child: const Text('Kaydet'),
                ),
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Kapat'))
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
