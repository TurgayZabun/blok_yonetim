import 'package:blok_yonetim/views/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../blok.dart';
import '../main_controller.dart';

class PopListPersonsInFlat extends StatelessWidget {
  final int daireNo;

  const PopListPersonsInFlat({super.key, required this.daireNo});

  @override
  Widget build(BuildContext context) {
    MainController mcont = Get.find();

    List<Birey> bireyler =
        mcont.bireyler.where((p0) => p0.daire == daireNo).toList();

    return Column(children: [
      Expanded(
        flex: 13,
        child: bireyler.isEmpty
            ? Center(
                child: Container(
                  color: Colors.amber,
                  child: const Text(
                      style: TextStyle(fontSize: 24),
                      'Bu daireye kayıtlı kişi yok.'),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(8.0),
                itemCount: bireyler.length,
                itemBuilder: (context, index) {
                  return NewWidget(
                    bireyler: bireyler,
                    mcont: mcont,
                    index: index,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
      ),
      ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Kapat'))
    ]);
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    super.key,
    required this.bireyler,
    required this.mcont,
    required this.index,
  });

  final List<Birey> bireyler;
  final MainController mcont;
  final int index;

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  late String selectedValue;

  @override
  Widget build(BuildContext context) {
    selectedValue = widget.mcont.getStatus(widget.bireyler[widget.index].key);

    return Card(
      color: Constants.durum[selectedValue] ?? Colors.white,
      child: ListTile(
        title: Text('${widget.bireyler[widget.index].adi} '
            '${widget.bireyler[widget.index].soyadi}'),
        subtitle: Obx(() =>
            Text(widget.mcont.getStatus(widget.bireyler[widget.index].key))),
        trailing: PopupMenuButton(
          onSelected: (value) => {
            selectedValue = value,
            setState(() {}),
            widget.mcont
                .chageSatus(widget.bireyler[widget.index].key, value.toString())
          },
          itemBuilder: (context) {
            List<PopupMenuItem> statusItems = [];
            Constants.durum.forEach((key, value) {
              statusItems.add(
                PopupMenuItem(
                  value: key,
                  child: Text(key),
                ),
              );
            });

            return statusItems;
          },
        ),
      ),
    );
  }
}
