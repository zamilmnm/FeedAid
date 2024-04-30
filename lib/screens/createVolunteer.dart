import 'dart:convert';
import 'package:feed_aid_app/widgets/Footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';
import '../widgets/FormButton.dart';
import '../widgets/InputField.dart';
import '../widgets/appBarWidget.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;

class CreateVolunteer extends StatefulWidget {
  const CreateVolunteer({super.key});

  @override
  State<CreateVolunteer> createState() => _CreateVolunteerState();
}

final _formKey = GlobalKey<FormBuilderState>();

class _CreateVolunteerState extends State<CreateVolunteer> {

  createVolunteer() async {
    var url = "$path/back_end/volunteer/create.php";

    var response = await http.post(Uri.parse(url), body: {
      "name": _formKey.currentState!.fields['name']!.value.toString().trim(),
      "address": _formKey.currentState!.fields['address']!.value.toString().trim(),
      "contact": _formKey.currentState!.fields['mobile']!.value.toString().trim(),
      "email": _formKey.currentState!.fields['email']!.value.toString().trim(),
    });

    try {
      if (response.body.isNotEmpty) {
        var volunteerData = json.decode(response.body);

        if (volunteerData == "Error") {
          Alert(
            context: context,
            type: AlertType.error,
            title: "Attempt failed!",
            desc: "Please contact the IT Department.....!",
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
        } else if (volunteerData == "not complete") {
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
            title: "Volunteer Created",
            desc: "Volunteer created successfully.....!",
            buttons: [
              DialogButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                width: 120,
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ).show().timeout(const Duration(seconds: 5));
        }
      }
    } catch (e) {
      debugPrint("caught error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bg_color,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: appbarWidget(
            name: 'Volunteer',
          ),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    height: screenHeight * 0.845,
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.32,
                        ),
                        SizedBox(
                          height: screenHeight * 0.5,
                          child: Column(
                            children: [
                              FormBuilder(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      const Text_field_mutiline(
                                        name: "name",
                                        hintText: 'Full name',
                                        fillColor: bg_color,
                                        lines_count: 1,
                                      ),
                                      const Text_field_mutiline(
                                        name: "address",
                                        hintText: 'Address',
                                        fillColor: bg_color,
                                        lines_count: 4,
                                      ),
                                      const Text_field_mutiline(
                                        name: "mobile",
                                        hintText: 'Contact No',
                                        fillColor: bg_color,
                                        lines_count: 1,
                                      ),
                                      const Text_field(
                                        name: "email",
                                        hintText: 'Email Address',
                                        icon: Icons.email_outlined,
                                        fillColor: bg_color,
                                      ),
                                      SizedBox(
                                        height: 80,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: FormButton(
                                                execute: () {
                                                  createVolunteer();
                                                },
                                                buttonColor:
                                                    const Color.fromRGBO(
                                                        0, 120, 254, 1),
                                                buttonTextColor:
                                                    text_color_dark,
                                                buttonText:
                                                    'Create Volunteer',
                                              ),
                                            ),
                                          ],
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: SizedBox(
                    height: screenHeight * 0.33,
                    child: Image.asset(
                      volunteer_bg,
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
