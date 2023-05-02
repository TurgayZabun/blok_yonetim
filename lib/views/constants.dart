// ignore_for_file: constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';

class Constants {
  static const String boxBlok = "blok";
  static Map<String, Color> durum = {
    'Mevcut': Colors.white,
    'Binada': Colors.red,
    'Farklı Lokasyonda': Colors.blue,
    'Belirsiz': Colors.red
  };

  static List<DropdownMenuItem> statusDropdownList() {
    List<DropdownMenuItem> statusList = [];

    durum.keys.forEach((element) {
      statusList.add(DropdownMenuItem(value: element, child: Text(element)));
    });

    return statusList;
  }

  //static const String boxDaireler = "daireler";
  //static const String boxBireyler = "bireyler";
}
