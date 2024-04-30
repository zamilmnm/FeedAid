import 'package:flutter/material.dart';
import '../constants.dart';

class menuWidget extends StatelessWidget {
  final String name;
  final Widget screen;

  const menuWidget({
    Key? key,
    required this.screenWidth,
    required this.name,
    required this.screen,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 40,
      width: screenWidth,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: theme_color)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            name,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: theme_color),
          ),
        ),
      ),
    );
  }
}

class topMenuWidget extends StatelessWidget {
  final String name;
  final Widget screen;

  const topMenuWidget({
    Key? key,
    required this.screenWidth,
    required this.name,
    required this.screen,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 40,
      width: screenWidth,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: theme_color),
          bottom: BorderSide(color: theme_color),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            name,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: theme_color),
          ),
        ),
      ),
    );
  }
}
