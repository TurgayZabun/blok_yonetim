import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main_controller.dart';

class BlokView extends StatelessWidget {
  BlokView({super.key});

  final TextEditingController blokAdi = TextEditingController();
  final TextEditingController ilkDaire = TextEditingController();
  final TextEditingController sonDaire = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MainController mcont = Get.find();

    blokAdi.text = mcont.blokAdi.value;
    ilkDaire.text = mcont.ilkDN.value.toString();
    sonDaire.text = mcont.sonDN.value.toString();

    return Form(
      key: _formKey,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (value) =>
                value!.isEmpty ? 'Blok adı boş olmamalı' : null,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.home),
                hintText: 'Blok tanımlanmamış'),
            //initialValue: mcont.blokAdi.value == null ? mcont.blokAdi.value : 'boş',
            //initialValue ve controller birlikte kullanılmıyor. bu yüzden kayıtlı blok verilerini controller text'e atayıp getiriyorum
            controller: blokAdi,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (value) =>
                value!.isEmpty ? 'İlk daire numarası boş olmamalı' : null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.format_list_numbered),
              hintText: 'İlk daire numarasını girin',
            ),
            controller: ilkDaire,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: (value) =>
                value!.isEmpty ? 'Son daire numarası boş olmamalı' : null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              icon: Icon(Icons.format_list_numbered),
              hintText: 'Son daire numarasını girin',
            ),
            controller: sonDaire,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              mcont.setBlok(blokAdi.text, int.parse(ilkDaire.text),
                  int.parse(sonDaire.text));
            } else {
              Get.snackbar('Hata', 'Eksik bilgileri tamamlamalısınız');
            }
          },
          child: const Text('Kaydet'),
        )
      ]),
    );
  }
}
