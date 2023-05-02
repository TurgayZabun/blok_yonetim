import 'package:blok_yonetim/blok.dart';
import 'package:blok_yonetim/views/constants.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainController extends GetxController {
  RxString blokAdiRx = ''.obs;
  RxInt pageObs = 0.obs;
  //gerek yok
  // RxInt ilkDN = 0.obs;
  // RxInt sonDN = 0.obs;
  RxList<Daire> daireler = <Daire>[].obs;
  RxList<Birey> bireyler = <Birey>[].obs;

  var box = Hive.box(Constants.boxBlok);

  Future<void> setBlok(String newBlokAdi) async {
    blokAdiRx.value = newBlokAdi;
    // this.ilkDN = ilkDN.obs;
    // this.sonDN = sonDN.obs;
    if (!box.isOpen) {
      await Hive.openBox(Constants.boxBlok);
    }
    box.put('blok', newBlokAdi);
  }

  Future<void> loadBlok() async {
    blokAdiRx.value = box.get('blok', defaultValue: 'Blok tanımlı değil');

    // ilkDN = RxInt(box.get('ilkDN', defaultValue: 0));
    // sonDN = RxInt(box.get('sonDN', defaultValue: 0));
    daireler.value = box.values.whereType<Daire>().toList();
    bireyler.value = box.values.whereType<Birey>().toList();
  }

  void addHouse(Daire daire) {
    daireler.add(daire);
    daire.addFlat(
        daire); //TODO: kendi kendini gönderiyor. doğru yöntem bu mu emin değilim.
  }

  void delHouse(Daire daire) {
    daireler.remove(daire);
    daire.delete(); //TODO: bu daireye kayıtlı birey var mı kontrol etmek lazım.
  }

  void saveHouse(Daire daire) {
    // daireler[daire.daireNo] =
    //     daire;
    //TODO: doğru daire geldiğinden emin olmak için geliştirme yapmak gerekli
    var daireRx =
        daireler.firstWhere((element) => element.key == daire.key).obs;
    daireRx.update((val) {
      val?.bulunduguBlok = daire.bulunduguBlok;
      val?.bulunduguKat = daire.bulunduguKat;
      val?.daireNo = daire.daireNo;
    }); //sanırım bu daha doğru
    daireler.refresh();
    daire.save();
  }

  void addPerson(Birey birey) {
    bireyler.add(birey);
    birey.addPerson(
        birey); //TODO: kendi kendini gönderiyor. doğru yöntem bu mu emin değilim.
  }

  void delPerson(Birey birey) {
    bireyler.remove(birey);
    birey.deletePerson(birey);
    //TODO: kendi kendini gönderiyor. doğru yöntem bu mu emin değilim.
    //hivetype olduğu için kendi metodu daha mı doğru?
  }

  void savePerson(Birey birey) {
    var bireyRx =
        bireyler.firstWhere((element) => element.key == birey.key).obs;
    bireyRx.update((val) {
      val?.adi = birey.adi;
      val?.daire = birey.daire;
      val?.soyadi = birey.soyadi;
      val?.telefon = birey.telefon;
    });
    bireyler.refresh();
    birey.save();
  }

  Daire getHouse(String keyHouse) =>
      daireler.where((p0) => p0.key == keyHouse).first;

  int livingInFlat(int flatNo) =>
      bireyler.where((p0) => p0.daire == flatNo).length;

  int safePersonInFlat(int flatNo) => bireyler
      .where((p0) => p0.daire == flatNo)
      .where((element) =>
          element.durum == "Mevcut" || element.durum == "Farklı Lokasyonda")
      .length;

  void chageSatus(int key, String newDurum) {
    bireyler.firstWhere((element) => element.key == key).durum = newDurum;
    bireyler.refresh();
    Birey birey = box.get(key);
    birey.durum = newDurum;
    birey.save();
    //TODO: Burası çok tehlikeli. aynı key'e sahip daire de gelebilir!!!
  }

  String getStatus(int key) =>
      bireyler.firstWhere((element) => element.key == key).durum;

  Future<void> removeBox() async {
    var isBox = await Hive.boxExists(Constants.boxBlok);
    bool isOpen = box.isOpen;

    if (isBox && isOpen) {
      await box.clear();

      //var newBox = Hive.openBox('new');
      loadBlok();
    }
  }
}
