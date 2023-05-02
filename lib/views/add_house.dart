import 'package:blok_yonetim/blok.dart';
import 'package:blok_yonetim/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddHouse extends StatefulWidget {
  const AddHouse({super.key});

  @override
  State<AddHouse> createState() => _AddHouseState();
}

class _AddHouseState extends State<AddHouse> {
  TextEditingController daireNo = TextEditingController();
  TextEditingController katNo = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MainController mcont = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daire Ekle'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) =>
                      value == '' ? 'Daire no boş olmamalı' : null,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Daire No'),
                    border: OutlineInputBorder(),
                    hintText: 'Daire numarası',
                  ),
                  controller: daireNo,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) => value == '' ? 'Kat boş olmamalı' : null,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Kat No'),
                    border: OutlineInputBorder(),
                    hintText: 'Bulunduğu kat',
                  ),
                  controller: katNo,
                ),
              ),
              //NumberPicker(          minValue: 1,          maxValue: 10,          value: 1,          onChanged: (_) {},        ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        var daire = Daire(
                            daireNo: int.parse(daireNo.text),
                            bulunduguKat: int.parse(katNo.text),
                            bulunduguBlok: mcont.blokAdiRx.string);
                        //daire.addDaire(daire);
                        mcont.addHouse(daire);
                        Get.back();
                      } else {
                        Get.snackbar('Hata', 'Eksik alanları doldurunuz',
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
      ),
    );
  }
}
