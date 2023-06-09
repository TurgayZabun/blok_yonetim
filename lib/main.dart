import 'package:blok_yonetim/main_controller.dart';
import 'package:blok_yonetim/views/add_blok.dart';
import 'package:blok_yonetim/views/constants.dart';
import 'package:blok_yonetim/views/list_person.dart';
import 'package:blok_yonetim/views/list_flat.dart';
import 'package:blok_yonetim/views/main_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'blok.dart';

void main() async {
  await Hive.initFlutter('veriler');

  Hive.registerAdapter<Blok>(BlokAdapter());
  Hive.registerAdapter<Daire>(DaireAdapter());
  Hive.registerAdapter<Birey>(BireyAdapter());

  //box.clear();
  await Hive.openBox(Constants.boxBlok);

  final MainController mainController = Get.put(MainController());
  mainController.loadBlok();

  runApp(const GetMaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainController mainController = Get.find();

  final List<Widget> _pages = [
    MainWidget(),
    FlatsList(),
    PersonList(),
    BlokView()
  ];
  //int _pageId = 0;

  void _chagePage(int page) {
    mainController.pageObs.value = page;
    //Obx ile yaptım state e gerek kalmadı.
    //setState(() {
    //  _pageId = page;
    //});
  }

  @override
  Widget build(BuildContext context) {
    mainController.blokAdiRx.value == 'Blok tanımlı değil'
        ? _chagePage(3)
        : null;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Blok Yönetimi"),
          ),
          body: Column(
            children: <Expanded>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Obx(
                    () => Text(mainController.blokAdiRx.value),
                  ),
                ),
              ),
              Expanded(
                  flex: 14,
                  child: Obx(() => _pages[mainController.pageObs.value]))
            ],
          ),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: mainController.pageObs.value,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "Ana Sayfa"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_home), label: "Daireler"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_add), label: "Kişiler"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.abc), label: "Tanımlar"),
                ],
                onTap: (int index) {
                  _chagePage(index);
                  //Get.to(AddBlok());
                }),
          ),
        ),
      ),
    );
  }
}
