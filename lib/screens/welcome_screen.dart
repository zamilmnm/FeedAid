import 'package:feed_aid_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/Footer.dart';
import '../widgets/FormButton.dart';

class Welcome_screen extends StatelessWidget {
  const Welcome_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double ScreenHeight = MediaQuery.of(context).size.height;
    final double ScreenWidth = MediaQuery.of(context).size.width;

    Redirect () async => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const LoginScreen()));

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:20, left: 15, right: 15),
            child: SizedBox(
              height: ScreenHeight*0.875,
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenHeight*0.05,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: ScreenHeight*0.25,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: ScreenHeight*0.1,
                          child: const Text(
                            'Welcome to,',
                            style: TextStyle(
                              color: text_color_light,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: double.maxFinite,
                            height: ScreenHeight*0.09,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  'Feed Aid',
                                  style: TextStyle(
                                    color: Color.fromRGBO(149, 44, 174, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                                ),
                                Text(
                                  'App',
                                  style: TextStyle(
                                    color: Color.fromRGBO(2, 66, 115, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenHeight*0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              height: ScreenHeight*0.45,
                              child: Row(),
                            ),
                            Image.asset(
                              welcome_bg,
                              fit: BoxFit.fitWidth,
                              width: ScreenWidth*2,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 70,
                      child: FormButton(execute: (){
                        Redirect();
                      }, buttonColor: const Color.fromRGBO(159, 222, 125, 1),
                        buttonTextColor: text_color_light,
                        buttonText: 'Get Started!',),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const footer(),
        ],
      ),
    );
  }
}



