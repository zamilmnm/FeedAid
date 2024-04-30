import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../constants.dart';

class Text_field extends StatelessWidget {
  final String name;
  final String hintText;
  final IconData icon;
  final Color fillColor;

  const Text_field(
      {Key? key,
      required this.name,
      required this.hintText,
      required this.icon,
      required this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: FormBuilderTextField(
        name: name,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: theme_color,
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: text_color_light, fontSize: 16),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              icon,
              color: theme_color,
            ),
          ),
        ),
      ),
    );
  }
}

class Text_field_mutiline extends StatelessWidget {
  final String name;
  final String hintText;
  final Color fillColor;
  final int lines_count;

  const Text_field_mutiline(
      {Key? key,
      required this.name,
      required this.hintText,
      required this.lines_count,
      required this.fillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: FormBuilderTextField(
        name: name,
        textAlign: TextAlign.left,
        maxLines: lines_count,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: theme_color,
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: text_color_light, fontSize: 16),
        ),
      ),
    );
  }
}

class dataViewWidget extends StatelessWidget {
  final double screenWidth;
  final String data;
  final double height;

  const dataViewWidget({
    Key? key,
    required this.screenWidth,
    required this.data,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: screenWidth,
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: Border.all(
            color: theme_color,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            data,
            style: const TextStyle(
              fontSize: 16,
              color: text_color_light,
            ),
          ),
        ),
      ),
    );
  }
}
