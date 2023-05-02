import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main_controller.dart';

class BlokView extends StatelessWidget {
  BlokView({super.key});

  final TextEditingController controllerBlokAdi = TextEditingController();
  // final TextEditingController ilkDaire = TextEditingController();
  // final TextEditingController sonDaire = TextEditingController();
  final focusNode = FocusNode();
  final MainController mcont = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mcont.blokAdiRx.value == 'Blok tanımlı değil'
        ? controllerBlokAdi.text = ''
        : controllerBlokAdi.text = mcont.blokAdiRx.value;
    // gerek yok
    // ilkDaire.text = mcont.ilkDN.value.toString();
    // sonDaire.text = mcont.sonDN.value.toString();

    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) =>
                    value!.isEmpty ? 'Blok adı boş olmamalı' : null,
                focusNode: focusNode,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.home),
                    hintText: 'Blok adı giriniz'),
                //initialValue: mcont.blokAdi.value == null ? mcont.blokAdi.value : 'boş',
                //initialValue ve controller birlikte kullanılmıyor. bu yüzden kayıtlı blok verilerini controller text'e atayıp getiriyorum
                controller: controllerBlokAdi,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        mcont.setBlok(controllerBlokAdi.text);
                        focusNode.unfocus();
                      } else {
                        Get.snackbar(
                            'Hata', 'Eksik bilgileri tamamlamalısınız');
                      }
                    },
                    child: const Text('Kaydet'),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.dialog(AlertDialog(
                          icon: const Icon(Icons.report_problem_outlined),
                          title: const Text(
                              'Dikkat! Tüm veriler geri alınamayacak şekilde silinecektir.'),
                          actions: [
                            ElevatedButton(
                                onPressed: () async {
                                  controllerBlokAdi.text = '';
                                  await mcont.removeBox();
                                  Get.back();
                                },
                                child: const Text('Sil')),
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text('İptal')),
                          ],
                        ));
                      },
                      child: const Text('Kayıtları Sil'))
                ],
              ),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            color: Colors.amber,
            child: Obx(
              () => Visibility(
                visible: mcont.blokAdiRx.value == 'Blok tanımlı değil'
                    ? true
                    : false,
                child: const Text(
                    style: TextStyle(fontSize: 16),
                    '*Uygulamayı kullanmaya başlamadan önce blok adı tanımlamalısınız.\n'
                    '*Daireler bölümünden daire numaraları ve bulundukları katları girebilirsiniz.\n'
                    '*Kişiler bölümünden blokta yaşayan kişileri ve hangi daire olduklarını girebilirsiniz.\n'
                    '*Ana sayfada katlardaki daireleri, dairede kaç kişi kayıtlı ve kaç kişinin kritik durumda olduğunu görebilirsiniz.\n'
                    '*Ana sayfada daireyi tıklayarak dairedeki kişilerin toplanma alanında olup olmadığını girebilirsiniz.'),
              ),
            ),
          ),
        )
      ],
    );
  }
}
