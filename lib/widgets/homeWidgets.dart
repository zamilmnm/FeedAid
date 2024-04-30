import 'package:feed_aid_app/constants.dart';
import 'package:feed_aid_app/screens/requestScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../APIs/home/homeDonation.dart';
import '../APIs/home/homePrediction.dart';
import '../APIs/home/homeRequest.dart';

class homeBadgeWidget extends StatelessWidget {
  final double screenWidth;
  final Color color;
  final String title;
  final String count;

  const homeBadgeWidget({
    Key? key,
    required this.screenWidth,
    required this.color,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: screenWidth * 0.27,
        width: screenWidth * 0.27,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: bg_color),
            ),
            Text(
              count,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: bg_color),
            ),
          ],
        ),
      ),
    );
  }
}

class homeRequestWidget extends StatelessWidget {
  final double screenWidth;
  final HomeRequest req;

  const homeRequestWidget({
    Key? key,
    required this.screenWidth,
    required this.req,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RequestScreen()),
          );
        },
        child: Container(
          height: screenWidth * 0.32,
          width: screenWidth * 0.32,
          decoration: BoxDecoration(
            color: bg_color,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            children: [
              Container(
                alignment: AlignmentDirectional.center,
                height: screenWidth * 0.2,
                child: Image.network(
                  "http://10.0.2.2/feed_aid_app/assets/food/${req.fImage}",
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: screenWidth * 0.22,
                  alignment: AlignmentDirectional.center,
                  color: bg_color.withOpacity(0.7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        req.fName,
                        style: const TextStyle(
                            fontSize: 20, color: Color.fromRGBO(2, 66, 115, 1)),
                      ),
                      Text(
                        req.rCount,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(2, 66, 115, 1)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          DateFormat('dd-MM-y').format(req.date).toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(251, 126, 91, 1)),
                        ),
                      ),
                    ],
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

class homeDonationWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final HomeDonation don;

  const homeDonationWidget({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    required this.don,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        height: screenWidth * 0.32,
        width: screenWidth * 0.48,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 120, 254, 1),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                height: screenWidth * 0.1,
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  DateFormat('dd-MM-y').format(don.date).toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(241, 173, 40, 1),
                  ),
                ),
              ),
              SizedBox(
                height: screenWidth * 0.21,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            "Food :",
                            style: TextStyle(
                                fontSize: 16,
                                color: bg_color,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              don.food,
                              style:
                                  const TextStyle(fontSize: 16, color: bg_color),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            "Count :",
                            style: TextStyle(
                                fontSize: 16,
                                color: bg_color,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Text(
                              don.rCount,
                              style:
                                  const TextStyle(fontSize: 16, color: bg_color),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Location :",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: bg_color,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              don.location,
                              style:
                                  const TextStyle(fontSize: 16, color: bg_color),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class homePredictionWidget extends StatelessWidget {
  final Prediction predict;
  const homePredictionWidget({
    Key? key,
    required this.predict,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Container(
          height: 40,
          width: double.maxFinite,
          alignment: AlignmentDirectional.centerStart,
          child: Text.rich(
            softWrap: true,
            TextSpan(
              text: 'Expected Requests: ',
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green),
              children: [
                TextSpan(
                  text: predict.request,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight:
                      FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 40,
          width: double.maxFinite,
          alignment: AlignmentDirectional.centerStart,
          child: Text.rich(
            softWrap: true,
            TextSpan(
              text: 'Expected Required Foods: ',
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blue),
              children: [
                TextSpan(
                  text: predict.food,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight:
                      FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 40,
          width: double.maxFinite,
          alignment: AlignmentDirectional.centerStart,
          child: Text.rich(
            softWrap: true,
            TextSpan(
              text: 'Foods to increase in quantity: ',
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.orange),
              children: [
                TextSpan(
                  text: predict.increse.toString().replaceAll(RegExp(r"\p{P}", unicode: true), ""),
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight:
                      FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 40,
          width: double.maxFinite,
          alignment: AlignmentDirectional.centerStart,
          child: Text.rich(
            softWrap: true,
            TextSpan(
              text: 'Foods to decrease in quantity: ',
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red),
              children: [
                TextSpan(
                  text: predict.decrese.toString().replaceAll(RegExp(r"\p{P}", unicode: true), ""),
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight:
                      FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
