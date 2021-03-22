import 'package:ccextractor/providers/menu_provider.dart';
import 'package:ccextractor/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuTile extends StatelessWidget {
  final int id;
  final String title;
  final IconData icon;
  final Function onClick;
  bool selected;
  MenuTile(this.id, this.title, this.icon, this.onClick, this.selected);
  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    return ListTile(
      enableFeedback: true,
      selectedTileColor: background,
      leading: Icon(
        icon,
        color: selected ? blue : secondaryText,
      ),
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: selected ? blue : secondaryText, fontSize: 14),
      ),
      hoverColor: background,
      onTap: () {
        menuProvider.resetMenuSelection();
        menuProvider.selectMenu(id);
      },
      selected: selected,
    );
  }
}
