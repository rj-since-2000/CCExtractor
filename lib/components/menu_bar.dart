import 'package:ccextractor/components/sub_components/custom_divider.dart';
import 'package:ccextractor/components/sub_components/menu_tile.dart';
import 'package:ccextractor/providers/menu_provider.dart';
import 'package:ccextractor/res/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height;
    var availableWidth = MediaQuery.of(context).size.width;
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    return Container(
      height: availableHeight * 0.75,
      width: availableWidth * 0.17,
      color: foreground,
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: 200),
            padding: EdgeInsets.symmetric(
                horizontal: padding, vertical: padding * 2),
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: EdgeInsets.all(padding),
            height: availableHeight * 0.1,
            alignment: Alignment.bottomLeft,
            color: foreground,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: blue,
                    radius: 15,
                  ),
                  SizedBox(
                    width: padding,
                  ),
                  Text(
                    'Carlos Fernandez',
                    style: TextStyle(color: primaryText, fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          CustomDivider(),
          Expanded(
            child: Container(
              color: foreground,
              child: ListView.builder(
                itemCount: menuProvider.menuItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Consumer<MenuProvider>(
                    builder: (context, menu, child) {
                      return MenuTile(
                        menu.menuItems[index].id,
                        menu.menuItems[index].title,
                        menu.menuItems[index].icon,
                        menu.menuItems[index].onClick,
                        menu.menuItems[index].isSelected,
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
