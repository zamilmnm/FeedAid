import 'dart:convert';

import 'package:feed_aid_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/Footer.dart';
import '../widgets/FormButton.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/dropdownWidget.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;

class FoodDonateScreen extends StatefulWidget {
  const FoodDonateScreen({super.key});

  @override
  State<FoodDonateScreen> createState() => _FoodDonateScreenState();
}

final _formKey = GlobalKey<FormBuilderState>();

class _FoodDonateScreenState extends State<FoodDonateScreen> {
  int count = 0;

  createFoodDonation() async {
    String selectedFood = _formKey.currentState!.fields['food']!.value;
    int selectedCount = count;

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String donor = sharedPreferences.getString('uId').toString();

    var url = "$path/back_end/foodDonate/create.php";

    var response = await http.post(Uri.parse(url), body: {
      "food": selectedFood.toString().trim(),
      "count": selectedCount.toString().trim(),
      "donor": donor.toString().trim(),
    });

    try {
      if (response.body.isNotEmpty) {
        var donationData = json.decode(response.body);

        if (donationData == "Error") {
          Alert(
            context: context,
            type: AlertType.error,
            title: "Something went to wrong",
            desc: "Please contact the IT department.....!",
            buttons: [
              DialogButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                width: 120,
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ).show().timeout(const Duration(seconds: 5));
        } else if (donationData == "not complete") {
          Alert(
            context: context,
            type: AlertType.info,
            title: "Fields are Empty",
            desc: "Please fill-up the all required fields.....!",
            buttons: [
              DialogButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                width: 120,
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ).show().timeout(const Duration(seconds: 5));
        } else {
          Alert(
            context: context,
            type: AlertType.success,
            title: "Donation succeed",
            desc: "Food Donated to the Charity Successfully.....!",
            buttons: [
              DialogButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                ),
                width: 120,
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ).show().timeout(const Duration(seconds: 3));
        }
      }
    } catch (e) {
      debugPrint('caught Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bg_color,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbarWidget(
            name: 'Food Donation',
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: screenHeight * 0.845,
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.345,
                      ),
                      SizedBox(
                        height: screenHeight * 0.5,
                        child: Column(
                          children: [
                            FormBuilder(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: screenWidth,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: screenWidth * 0.535,
                                            child: const dropdownWidget(),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            width: screenWidth * 0.35,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: theme_color
                                                    .withOpacity(0.4),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25.0)),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.chevron_left,
                                                      color: theme_color
                                                          .withOpacity(0.4),
                                                    ),
                                                    iconSize: 32.0,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    onPressed: () {
                                                      setState(() {
                                                        if (count > 1) {
                                                          count--;
                                                        }
                                                        // widget.onChanged(count);
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '$count',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: text_color_light,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.chevron_right,
                                                      color: theme_color
                                                          .withOpacity(0.4),
                                                    ),
                                                    iconSize: 32.0,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    onPressed: () {
                                                      setState(() {
                                                        if (count < 20) {
                                                          count++;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: screenHeight * 0.05),
                                      child: SizedBox(
                                        height: 80,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: screenWidth * 0.7,
                                              child: FormButton(
                                                execute: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    createFoodDonation();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Processing Data')),
                                                    );
                                                  }
                                                },
                                                buttonColor:
                                                    const Color.fromRGBO(
                                                        0, 120, 254, 1),
                                                buttonTextColor:
                                                    text_color_dark,
                                                buttonText: 'Add',
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 10),
                  child: SizedBox(
                    height: screenHeight * 0.3,
                    child: Image.asset(
                      foodDonate_bg,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
            const footer(),
          ],
        ));
  }
}
