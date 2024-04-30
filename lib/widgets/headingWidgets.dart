import 'package:flutter/material.dart';

import '../constants.dart';

class headingWidget extends StatelessWidget {
  final String heading;
  const headingWidget({
    Key? key, required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          heading,
          style: const TextStyle(
              fontSize: 22,
              color: text_color_light,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}