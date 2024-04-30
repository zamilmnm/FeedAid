import 'package:feed_aid_app/constants.dart';
import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final Function() execute;
  final Color buttonColor;
  final Color buttonTextColor;
  final String? buttonText;
  const FormButton({
    Key? key,
    required this.execute,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 20,
          child: SizedBox(
            child: ElevatedButton(
              onPressed: execute,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ), backgroundColor: buttonColor,),
                  // const Color.fromRGBO(159, 222, 125, 1)),
              child: Text(
                buttonText!,
                style: TextStyle(
                    color: buttonTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
      ],
    );
  }
}

class FormButtonv2 extends StatelessWidget {
  final Function() execute;
  final String? buttonText;
  const FormButtonv2({
    Key? key,
    required this.execute,
    required this.buttonText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 20,
          child: SizedBox(
            child: ElevatedButton(
              onPressed: execute,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ), backgroundColor: bg_color,
                side: const BorderSide(
                  width: 1.0,
                  color: theme_color,
                  // style: BorderStyle.solid,
                ),),
              // const Color.fromRGBO(159, 222, 125, 1)),
              child: Text(
                buttonText!,
                style: const TextStyle(
                    color: theme_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
      ],
    );
  }
}