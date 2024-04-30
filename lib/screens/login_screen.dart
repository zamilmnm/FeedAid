import 'dart:convert';
import 'package:feed_aid_app/screens/CreateNewAccount.dart';
import 'package:feed_aid_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../widgets/Footer.dart';
import '../widgets/FormButton.dart';
import '../widgets/InputField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormBuilderState>();
  bool invisible = true;

  String actor = 'user';

  void checkUser(String value ) {
    setState(() {
      actor = value;
    });
  }
  void viewPassword() {
    setState(() {
      invisible = !invisible;
    });
  }

  login() async {
    String email = _formKey.currentState!.fields['email']!.value.toString();
    String password = _formKey.currentState!.fields['password']!.value.toString();

    var url =
        "$path/back_end/user/login.php";

    var response = await http.post(Uri.parse(url), body: {
      "email": email.trim(),
      "password": password.trim(),
      "userType": actor,
    });

    late List user = [];

    try {
      if (response.body.isNotEmpty) {
        var userData = json.decode(response.body);

        if (userData == "Email Error") {
          Alert(
            context: context,
            type: AlertType.error,
            title: "Wrong Email",
            desc: "The Email Address not found.....!",
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
        } else if (userData == "Password Error") {
          Alert(
            context: context,
            type: AlertType.error,
            title: "Wrong Password",
            desc: "The Passwords is not matched.....!",
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
        } else if (userData == "not complete") {
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
          user = json.decode(response.body);

          SharedPreferences.setMockInitialValues({});
          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('uId', user[0]['uId']);
          sharedPreferences.setString('username', user[0]['username']);
          sharedPreferences.setString('userType', user[0]['userType']);

          Alert(
            context: context,
            type: AlertType.success,
            title: "Login verified",
            desc: "Welcome to Feed Aid App.....!",
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
    debugPrint("Email : $email");
    debugPrint("Password : $password");
    debugPrint("Actor : $actor");
  }

  redirect () async => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
          const CreateNewAccount()));

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.5),
                      child: SizedBox(
                        height: screenHeight * 0.4,
                        width: double.maxFinite,
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Text_field(name: "email", hintText: 'Email Address', icon: Icons.email_outlined, fillColor: bg_color,),
                              Stack(
                                children: [
                                  FormBuilderTextField(
                                    name: "password",
                                    obscureText: invisible,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: const TextStyle(color: text_color_light, fontSize: 16),
                                      filled: true,
                                      fillColor: bg_color,
                                      contentPadding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: const BorderSide(
                                          color: theme_color,
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: IconButton(
                                        splashRadius: 1,
                                        icon:Icon(
                                          invisible ?
                                          Icons.remove_red_eye_outlined:
                                          Icons.lock_outline,
                                        ),
                                        onPressed: viewPassword,
                                        color: theme_color.withOpacity(0.5),
                                      ),
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
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  height: 110,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: FormButton(
                                          execute: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              login();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Processing Data')),
                                              );
                                            }
                                          },
                                          buttonColor: theme_color,
                                          buttonTextColor: text_color_dark,
                                          buttonText: 'Login',
                                        ),
                                      ),
                                      Expanded(
                                        child: FormButtonv2(
                                        execute: () {
                                          redirect ();
                                        },
                                        buttonText: 'Create New Account',
                                      ),)
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
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.12),
                child: SizedBox(
                  height: screenHeight * 0.54,
                  child: Image.asset(
                    login_bg,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
          const footer(),
        ],
      ),
    );
  }
}

