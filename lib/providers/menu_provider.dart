import 'package:ccextractor/models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  List<MenuItem> menuItems = [
    MenuItem(1, 'Dashboard', Icons.dashboard, () {}, true),
    MenuItem(2, 'Advanced Input options', Icons.input, () {}, false),
    MenuItem(3, 'Decoders', Icons.device_hub_rounded, () {}, false),
    MenuItem(4, 'Advanced Output options', Icons.outbox, () {}, false),
    MenuItem(5, 'Debug', Icons.bug_report_outlined, () {}, false),
    MenuItem(6, 'HDHomeRun', Icons.repeat_rounded, () {}, false),
    MenuItem(7, 'Burned-in Subtitle Extraction', Icons.extension_outlined,
        () {}, false),
    MenuItem(8, 'Credits', Icons.credit_card_sharp, () {}, false),
    MenuItem(9, 'About & Save', Icons.save_alt_rounded, () {}, false),
  ];

  int _currentMenuId = 1;

  int get currentMenuId {
    return _currentMenuId;
  }

  resetMenuSelection() {
    menuItems.forEach((element) {
      element.isSelected = false;
    });
  }

  selectMenu(int id) {
    _currentMenuId = id;
    menuItems.firstWhere((element) => element.id == id).isSelected = true;
    notifyListeners();
  }
}
