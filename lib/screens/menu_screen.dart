import 'package:feed_aid_app/screens/account_screen.dart';
import 'package:feed_aid_app/screens/beneficiaryRequest_screen.dart';
import 'package:feed_aid_app/screens/createVolunteer.dart';
import 'package:feed_aid_app/screens/feedback_screen.dart';
import 'package:feed_aid_app/screens/foodDonate_screen.dart';
import 'package:feed_aid_app/screens/home_screen.dart';
import 'package:feed_aid_app/screens/login_screen.dart';
import 'package:feed_aid_app/screens/notification_screen.dart';
import 'package:feed_aid_app/screens/requestScreen.dart';
import 'package:feed_aid_app/widgets/Footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../widgets/menuWidget.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String name = 'user';
  String userType = 'Un-Authorised User';
  String userImage = menu_donar;
  Color colorTheme = Colors.grey;

  void getUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString('username').toString();
      userType = sharedPreferences.getString('userType').toString();

      if (userType == "Donor") {
        userImage = menu_donar;
        colorTheme = const Color.fromRGBO(159, 222, 125, 1);
      } else {
        userImage = menu_beneficiary;
        colorTheme = const Color.fromRGBO(247, 171, 82, 1);
      }
    });
  }

  @override
  void initState() {
    getUser();
    loginVerification();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loginVerification() async {
    try {
      final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      final String? id = sharedPreferences.getString('uId');

      debugPrint("user id: $id");

      if (id == null) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        });
      }
    } catch (e) {
      debugPrint("caught error: $e");
    }
  }

  logout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('uId');
    sharedPreferences.remove('username');
    sharedPreferences.remove('userType');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool show;

    if (userType == 'Donor') {
      show = true;
    } else {
      show = false;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bg_color,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.25),
        child: AppBar(
          backgroundColor: theme_color,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: SizedBox(
              height: 170,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Material(
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: colorTheme,
                        child: Image(
                          image: AssetImage(userImage),
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: text_color_dark,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Text(
                    userType,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorTheme,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Visibility(
          visible: show,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FoodDonateScreen()),
              );
            },
            backgroundColor: theme_color,
            child: const Icon(Icons.add, size: 30, color: bg_color,),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.685,
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: IconButton(
                        onPressed: () {
                          logout();
                        },
                        icon: Icon(
                          Icons.logout,
                          color: theme_color,
                          size: screenHeight * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
                topMenuWidget(
                  screenWidth: screenWidth,
                  name: 'HOME',
                  screen: const HomeScreen(),
                ),
                menuWidget(
                  screenWidth: screenWidth,
                  name: 'ACCOUNT',
                  screen: const AccountScreen(),
                ),
                if (userType == 'Donor') ...[
                  menuWidget(
                    screenWidth: screenWidth,
                    name: 'DONATIONS',
                    screen: const FoodDonateScreen(),
                  ),
                  menuWidget(
                    screenWidth: screenWidth,
                    name: 'REQUESTS',
                    screen: const RequestScreen(),
                  ),
                  menuWidget(
                    screenWidth: screenWidth,
                    name: 'VOLUNTEER',
                    screen: const CreateVolunteer(),
                  ),
                  menuWidget(
                    screenWidth: screenWidth,
                    name: 'FEEDBACKS',
                    screen: const FeedbackScreen(),
                  ),
                  menuWidget(
                    screenWidth: screenWidth,
                    name: 'NOTIFICATIONS',
                    screen: const NotificationScreen(),
                  ),
                ] else ...[
                  menuWidget(
                    screenWidth: screenWidth,
                    name: 'MY REQUESTS',
                    screen: const BeneficiaryRequestScreen(),
                  ),
                ],
              ],
            ),
          ),
          const footer(),
        ],
      ),
    );
  }
}
