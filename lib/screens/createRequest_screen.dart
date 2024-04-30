import 'dart:convert';
import 'package:feed_aid_app/constants.dart';
import 'package:feed_aid_app/screens/beneficiaryRequest_screen.dart';
import 'package:feed_aid_app/widgets/Footer.dart';
import 'package:feed_aid_app/widgets/InputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/FormButton.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/dropdownWidget.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

final _formKey = GlobalKey<FormBuilderState>();

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  String currentDate = DateFormat('dd-MM-y').format(DateTime.now()).toString();

  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  createRequest() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String beneficiary = sharedPreferences.getString('uId').toString();

    String sFood = _formKey.currentState!.fields['food']!.value.toString();
    String reason = _formKey.currentState!.fields['reason']!.value.toString();
    String location =
        _formKey.currentState!.fields['location']!.value.toString();
    DateTime selectedDate = _formKey.currentState!.fields['date']!.value;
    int selectedFoodCount = count;

    var url = "$path/back_end/request/create.php";
    var response = await http.post(Uri.parse(url), body: {
      "food": sFood,
      "count": selectedFoodCount.toString(),
      "reason": reason,
      "requiredDate": selectedDate.toString(),
      "beneficiary": beneficiary,
      "location": location,
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
            title: "Request sent",
            desc: "Request created Successfully.....!",
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bg_color,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appbarWidget(
          name: 'Requests',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.845,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.25),
                  child: SizedBox(
                    height: screenHeight * 0.4,
                    child: Image.asset(
                      request_bg,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: screenHeight * 0.3, right: 15, left: 15),
                  child: Container(
                    color: bg_color.withOpacity(0.5),
                    height: screenHeight * 0.585,
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: SizedBox(
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
                                        color: theme_color.withOpacity(0.4),
                                        width: 1.0,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25.0)),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.chevron_left,
                                              color:
                                                  theme_color.withOpacity(0.4),
                                            ),
                                            iconSize: 32.0,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.chevron_right,
                                              color:
                                                  theme_color.withOpacity(0.4),
                                            ),
                                            iconSize: 32.0,
                                            color:
                                                Theme.of(context).primaryColor,
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
                          ),
                          const Text_field_mutiline(
                              name: "reason",
                              hintText: "Reason",
                              lines_count: 4,
                              fillColor: bg_color),
                          const Text_field_mutiline(
                              name: "location",
                              hintText: "Location",
                              lines_count: 1,
                              fillColor: bg_color),
                          FormBuilderDateTimePicker(
                            name: 'date',
                            format: DateFormat('dd-MM-y'),
                            inputType: InputType.date,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  color: text_color_light, fontSize: 16),
                              errorStyle: const TextStyle(
                                  color: Colors.redAccent, fontSize: 16),
                              contentPadding: const EdgeInsets.only(left: 20),
                              fillColor: bg_color,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: theme_color,
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.event_note,
                                color: theme_color.withOpacity(0.4),
                              ),
                              hintText: currentDate.toString(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: SizedBox(
                              height: 110,
                              width: screenWidth * 0.7,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: FormButton(
                                      execute: () {
                                        if (_formKey.currentState!.validate()) {
                                          createRequest();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Processing Data')),
                                          );
                                        }
                                      },
                                      buttonColor:
                                          const Color.fromRGBO(0, 120, 254, 1),
                                      buttonTextColor: text_color_dark,
                                      buttonText: 'Create Request',
                                    ),
                                  ),
                                  Expanded(
                                    child: FormButton(
                                      execute: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BeneficiaryRequestScreen()),
                                      ),
                                      buttonColor:
                                          const Color.fromRGBO(254, 125, 88, 1),
                                      buttonTextColor: text_color_dark,
                                      buttonText: 'View Request',
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
                ),
              ],
            ),
          ),
          const footer(),
        ],
      ),
    );
  }
}
