import 'package:feed_aid_app/constants.dart';
import 'package:feed_aid_app/widgets/InputField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../APIs/user/user-api.dart';
import '../APIs/user/user.dart';
import '../widgets/Footer.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool invisible = true;

  String userID = '0';
  String userName = 'user';
  String userType = 'user';
  String userImage = menu_donar;
  Color colorTheme = Colors.grey;

  var url = "$path/back_end/user/view.php";


  void getUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    setState(() {
      userID = sharedPreferences.getString('uId').toString();
      userName = sharedPreferences.getString('username').toString();
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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void viewPassword() {
    setState(() {
      invisible = !invisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
                        color: colorTheme,
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          image: AssetImage(userImage.toString()),
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      userName,
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
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.685,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
              child: FutureBuilder(
                future: fetchUser(url, userID.toString(), userType.toString()),
                builder: (context, AsyncSnapshot<List<User>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, index) {
                          User users = snapshot.data![index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              dataViewWidget(
                                  height: 50,
                                  data: users.uName,
                                  screenWidth: screenWidth),
                              dataViewWidget(
                                  height: 150,
                                  data: users.uAddress,
                                  screenWidth: screenWidth),
                              dataViewWidget(
                                  height: 50,
                                  data: users.uContact,
                                  screenWidth: screenWidth),
                              Stack(
                                children: [
                                  dataViewWidget(
                                      height: 50,
                                      data: users.uEmail,
                                      screenWidth: screenWidth),
                                  const Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: 20, top: 15),
                                      child: Icon(
                                        Icons.email_outlined,
                                        color: theme_color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: screenWidth,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      border: Border.all(
                                        color: theme_color,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: FormBuilderTextField(
                                      name: 'password',
                                      enabled: false,
                                      obscureText: invisible,
                                      initialValue: users.uPassword,
                                      style: const TextStyle(
                                          color: text_color_light,
                                          fontSize: 16),
                                      decoration: const InputDecoration(
                                        filled: true,
                                        contentPadding: EdgeInsets.only(
                                            left: 20, top: 10, bottom: 10),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: IconButton(
                                        icon: Icon(
                                          invisible
                                              ? Icons.remove_red_eye_outlined
                                              : Icons.lock_outline,
                                        ),
                                        onPressed: viewPassword,
                                        color: theme_color,
                                        splashRadius: 0.2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        });
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
          const footer(),
        ],
      ),
    );
  }
}
