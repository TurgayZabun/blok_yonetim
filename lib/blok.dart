import 'package:blok_yonetim/views/constants.dart';
import 'package:hive/hive.dart';

part 'blok.g.dart';

@HiveType(typeId: 0)
class Blok extends HiveObject {
  @HiveField(0)
  late final String? _blokAdi;
  @HiveField(1)
  HiveList? daireler;

  Blok({blokAdi = 'Tanımlanmamış'}) : _blokAdi = blokAdi;

  String? get blokAdi => _blokAdi;
}

@HiveType(typeId: 1)
class Daire extends HiveObject {
  @HiveField(0)
  int daireNo;

  @HiveField(1)
  int bulunduguKat;

  @HiveField(2)
  String bulunduguBlok;

  @HiveField(3)
  HiveList? _bireyler;

  Daire(
      {required this.daireNo,
      required this.bulunduguKat,
      required this.bulunduguBlok});

  void addFlat(Daire daire) {
    var box = Hive.box(Constants.boxBlok);
    //TODO: aynı daire numarası daha önce var mı kontrol etmek gerekebilir.
    box.put(daire.daireNo.toString(), daire);
  }

  Daire getFlat(int daireNo) {
    var box = Hive.box(Constants.boxBlok);
    return box.get(daireNo.toString()) as Daire;
  }
}

@HiveType(typeId: 2)
class Birey extends HiveObject {
  @HiveField(0)
  String adi;

  @HiveField(1)
  String soyadi;

  @HiveField(2)
  String telefon;

  @HiveField(3)
  String durum;

  @HiveField(4)
  int daire;

  Birey(
      {required this.adi,
      required this.soyadi,
      required this.telefon,
      required this.durum,
      required this.daire});

  void addPerson(Birey birey) {
    Box box = Hive.box(Constants.boxBlok);
    box.add(birey);
  }

  void editPerson(Birey birey) {
    birey.save();
  }

  void deletePerson(Birey birey) {
    birey.delete();
  }
}
