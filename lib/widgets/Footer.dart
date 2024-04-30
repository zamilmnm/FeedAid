import 'package:feed_aid_app/constants.dart';
import 'package:flutter/material.dart';

class footer extends StatelessWidget {
  const footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: theme_color,
      ),
    );
  }
}