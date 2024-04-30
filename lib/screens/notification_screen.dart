import 'dart:convert';
import 'package:feed_aid_app/constants.dart';
import 'package:flutter/material.dart';
import '../widgets/Footer.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/headingWidgets.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late var notifyList = [];

  @override
  void initState() {
    super.initState();
    fetchNotifications();
    updateNotifications();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchNotifications() async {
    var url = "$path/back_end/notification/view.php";

    final response = await http.get(Uri.parse(url));
    var notificationList = json.decode(response.body);

    setState(() {
      notifyList = notificationList as List;
    });
  }

  updateNotifications() async {
    var url = "$path/back_end/notification/update.php";

    final response = await http.get(Uri.parse(url));
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
          name: 'Notifications',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.845,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: headingWidget(
                      heading: 'New Notifications',
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.65,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme_color,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: DataTable(
                          columnSpacing: 18,
                          horizontalMargin: 5,
                          headingRowHeight: 70,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Beneficiary',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: text_color_light,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Inadequate Food',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: text_color_light,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text(
                                  'Count',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: text_color_light,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Align(
                                  child: Text(
                                    'Date',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: text_color_light,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          rows: notifyList
                              .map(
                                (notification) => DataRow(
                                  cells: <DataCell>[
                                    DataCell(
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          notification['beneficiary']
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: text_color_light,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          notification['food'].toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: text_color_light,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          notification['fCount'].toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: text_color_light,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          notification['date'].toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: text_color_light,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
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
