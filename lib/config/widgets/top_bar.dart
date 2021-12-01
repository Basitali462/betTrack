import 'package:flutter/material.dart';
import 'package:flutter_bet_track/config/model/menu_item.dart';

class TopBar extends StatelessWidget {
  PopupMenuItem<String> buildItem(String item) {
    return PopupMenuItem(child: Text(item));
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: GestureDetector(
        onTap: (){
          Scaffold.of(context).openDrawer();
        },
        child: Image.asset(
          'assets/icons/menu-icon.png',
        ),
      ),
      title: Image.asset(
        'assets/icons/logo.png',
      ),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return MenuItem.createList.map((e) {
              return PopupMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList();
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 22),
            child: Image.asset(
              'assets/icons/3-dot.png',
            ),
          ),
        ),
      ],
    );
  }
}
