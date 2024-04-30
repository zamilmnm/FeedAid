import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/menu_screen.dart';

class appbarWidget extends StatelessWidget {
  final String name;
  const appbarWidget({
    Key? key, required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: theme_color,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: bg_color
        ),
      ),
      centerTitle: true,
      // automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
          icon: const Icon(
            Icons.menu,
            color: bg_color,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Menu()));
          },
        ),
      ),
    );
  }
}