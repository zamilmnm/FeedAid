import 'package:feed_aid_app/screens/feedback_screen.dart';
import 'package:flutter/material.dart';
import '../APIs/feedback/feedback.dart';
import '../constants.dart';
import 'package:intl/intl.dart';

class feedbackWidget extends StatelessWidget {
  final FeedbackList fBack;

  const feedbackWidget({
    Key? key, required this.fBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(2, 66, 115, 1),
            width: 2.0,
          ),
          borderRadius:
          const BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          fBack.beneficiary,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(2, 66, 115, 1),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                            DateFormat('dd-MM-y').format(fBack.date).toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(245, 170, 81, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 115,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(49, 83, 96, 1),
                  borderRadius:
                  BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    fBack.summary,
                    style: const TextStyle(
                      fontSize: 14,
                      color: bg_color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}