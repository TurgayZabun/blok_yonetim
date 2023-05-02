import 'package:blok_yonetim/blok.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main_controller.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({super.key});

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  TextEditingController ad = TextEditingController();

  TextEditingController soyad = TextEditingController();

  TextEditingController telefon = TextEditingController();

  TextEditingController daire = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MainController mcont = Get.find();

    return Scaffold(
        appBar: AppBar(title: const Text('Birey ekleme')),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ad',
                          labelText: 'Ad',
                        ),
                        controller: ad,
                        validator: (value) =>
                            value != '' ? null : 'Ad boş olmamalı',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Soyad',
                        ),
                        controller: soyad,
                        validator: (value) =>
                            value != '' ? null : 'Soyad boş olmamalı',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Telefon',
                        ),
                        controller: telefon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Daire No',
                        ),
                        controller: daire,
                        validator: (value) =>
                            value != '' ? null : 'Daire no boş olmamalı',
                      ),
                    ),
                    //NumberPicker(          minValue: 1,          maxValue: 10,          value: 1,          onChanged: (_) {},        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              Birey birey = Birey(
                                  adi: ad.text,
                                  soyadi: soyad.text,
                                  telefon: telefon.text,
                                  durum: '',
                                  daire: int.parse(daire.text));
                              mcont.addPerson(birey);
                              // birey.addPerson(birey);
                              //todo: normalde bunu kullanmadan listeyi oto yenilemesi gerek
                              Get.back();
                            } else {
                              Get.snackbar(
                                  'Hata', 'Eksik bilgileri tamamlamalısınız',
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          },
                          child: const Text('Kaydet'),
                        ),
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('İptal'))
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }
}
