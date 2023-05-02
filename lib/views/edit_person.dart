import 'package:blok_yonetim/blok.dart';
import 'package:blok_yonetim/main.dart';
import 'package:blok_yonetim/views/list_person.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main_controller.dart';

class EditPerson extends StatefulWidget {
  final Birey birey;

  const EditPerson({super.key, required this.birey});

  @override
  State<EditPerson> createState() => _EditPersonState();
}

class _EditPersonState extends State<EditPerson> {
  TextEditingController ad = TextEditingController();
  TextEditingController soyad = TextEditingController();
  TextEditingController telefon = TextEditingController();
  TextEditingController daire = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MainController mcont = Get.find();

    ad.text = widget.birey.adi;
    soyad.text = widget.birey.soyadi;
    telefon.text = widget.birey.telefon;
    daire.text = widget.birey.daire.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Birey Düzenle'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Ad boş olmamamlı' : null,
                  controller: ad,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    hintText: 'Ad',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Soyad boş olmamamlı' : null,
                  controller: soyad,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                    hintText: 'Soyad',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: telefon,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone_android),
                    border: OutlineInputBorder(),
                    hintText: 'Telefon',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Daire no boş olmamamlı' : null,
                  controller: daire,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.format_list_numbered_sharp),
                    border: OutlineInputBorder(),
                    hintText: 'Daire No',
                  ),
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
                        widget.birey.adi = ad.text;
                        widget.birey.soyadi = soyad.text;
                        widget.birey.telefon = telefon.text;
                        widget.birey.daire = int.parse(daire.text);
                        //widget.birey.editPerson(widget.birey);
                        mcont.savePerson(widget.birey);
                        Get.to(
                            MyApp()); //TODO: back arkadaki listeyi değiştirmedinden to ile gittim ama addperson açık kalıyor sanırım.
                        // Get.back(result: mcont);
                      } else {
                        Get.snackbar('Hata', 'Eksik bilgileri tamamlamalısınız',
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
      ),
    );
  }
}
