import 'package:flutter/material.dart';
import 'package:rjd_app/Screens/widgets/menu_item.dart';
import 'package:rjd_app/main.dart';

class Menupage extends StatelessWidget {
  final MenuItem current;
  final ValueChanged<MenuItem> onselect;

  const Menupage({
    Key? key,
    required this.current,
    required this.onselect,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            ...MenuItems.all.map(buildMenuItem).toList(),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
        selectedColor: Colors.white,
        selectedTileColor: Colors.red,
        child: ListTile(
          selected: current == item,
          minLeadingWidth: 20,
          leading: Icon(
            item.icon,
            color: Colors.white,
          ),
          title: Text(
            item.title,
            style: TextStyle(color: Colors.white, fontFamily: "font1"),
          ),
        ),
      );
}
