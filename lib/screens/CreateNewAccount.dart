import 'dart:convert';
import 'package:feed_aid_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants.dart';
import '../widgets/Footer.dart';
import '../widgets/FormButton.dart';
import '../widgets/InputField.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({Key? key}) : super(key: key);

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  final _formKey = GlobalKey<FormBuilderState>();

  String actor = 'user';

  void checkUser(String value) {
    setState(() {
      actor = value;
    });
  }

  createUser() async {
    String name = _formKey.currentState!.fields['name']!.value.toString();
    String address = _formKey.currentState!.fields['address']!.value.toString();
    String mobile = _formKey.currentState!.fields['mobile']!.value.toString();
    String email = _formKey.currentState!.fields['email']!.value.toString();
    String newPassword =
        _formKey.currentState!.fields['newPassword']!.value.toString();
    String password =
        _formKey.currentState!.fields['password']!.value.toString();

    var url = "$path/back_end/user/create.php";

    var response = await http.post(Uri.parse(url), body: {
      "name": name.trim(),
      "address": address.trim(),
      "contact": mobile.trim(),
      "email": email.trim(),
      "newPassword": newPassword.trim(),
      "password": password.trim(),
      "userType": actor,
    });

    try {
      if (response.body.isNotEmpty) {
        var userData = json.decode(response.body);
        debugPrint(userData);

        switch (userData) {
          case "Error":
            Alert(
              context: context,
              type: AlertType.error,
              title: "Attempt Failed...!",
              desc: "Please contact the IT Department.",
              buttons: [
                DialogButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  width: 120,
                  child: const Text(
                    "RETRY",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ).show();
            break;
          case "Success":
            Alert(
              context: context,
              type: AlertType.success,
              title: "Account Creation",
              desc: "User Account created Successfully.....!",
              buttons: [
                DialogButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  ),
                  width: 120,
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ).show().timeout(const Duration(seconds: 3));
            break;
          case "No match":
            Alert(
              context: context,
              type: AlertType.info,
              title: "Wrong Password",
              desc: "The Passwords are not matched.....!",
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
            break;
          case "not complete":
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
            break;
        }
      }
    } catch (e) {
      debugPrint('caught Error: $e');
    }
  }

  redirect() async => Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LoginScreen()));

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bg_color,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(13),
        child: AppBar(
          backgroundColor: theme_color,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.9,
            child: Stack(
              children: [
                Image.asset(
                  register_bg,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    height: screenHeight * 0.9,
                    width: screenWidth,
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            color: Colors.transparent,
                            height: screenHeight * 0.75,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.2,
                                ),
                                SizedBox(
                                  height: screenHeight * 0.55,
                                  child: Column(
                                    children: [
                                      const Text_field_mutiline(
                                        name: "name",
                                        hintText: 'Full Name',
                                        fillColor: Colors.transparent,
                                        lines_count: 1,
                                      ),
                                      const Text_field_mutiline(
                                        name: "address",
                                        hintText: 'Address',
                                        fillColor: Colors.transparent,
                                        lines_count: 4,
                                      ),
                                      const Text_field_mutiline(
                                        name: "mobile",
                                        hintText: 'Contact Number',
                                        fillColor: bg_color,
                                        lines_count: 1,
                                      ),
                                      const Text_field(
                                        name: "email",
                                        hintText: 'E-mail Address',
                                        fillColor: bg_color,
                                        icon: Icons.email_outlined,
                                      ),
                                      const Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text_field_mutiline(
                                              name: "newPassword",
                                              hintText: 'New Password',
                                              fillColor: bg_color,
                                              lines_count: 1,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 0,
                                            child: SizedBox(
                                              width: 5,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text_field_mutiline(
                                              name: "password",
                                              hintText: 'Confirm Password',
                                              fillColor: bg_color,
                                              lines_count: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: ListTile(
                                              title: const Text(
                                                'Donor',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: text_color_light),
                                              ),
                                              leading: Radio(
                                                activeColor: theme_color,
                                                value: 'Donor',
                                                groupValue: actor,
                                                onChanged: (value) {
                                                  checkUser(value as String);
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: ListTile(
                                              title: const Text(
                                                'Beneficiary',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: text_color_light),
                                              ),
                                              leading: Radio(
                                                activeColor: theme_color,
                                                value: 'Beneficiary',
                                                groupValue: actor,
                                                onChanged: (value) {
                                                  checkUser(value as String);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.15,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.007,
                                ),
                                SizedBox(
                                  height: screenHeight * 0.123,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: FormButton(
                                          execute: () {
                                            createUser();
                                          },
                                          buttonColor: theme_color,
                                          buttonTextColor: text_color_dark,
                                          buttonText: 'Register',
                                        ),
                                      ),
                                      Expanded(
                                        child: FormButtonv2(
                                          execute: () {
                                            redirect();
                                          },
                                          buttonText: 'Sign in',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                              ],
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
