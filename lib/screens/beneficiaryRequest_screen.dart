import 'dart:convert';
import 'package:feed_aid_app/screens/createRequest_screen.dart';
import 'package:feed_aid_app/screens/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../widgets/Footer.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/headingWidgets.dart';

class BeneficiaryRequestScreen extends StatefulWidget {
  const BeneficiaryRequestScreen({super.key});

  @override
  State<BeneficiaryRequestScreen> createState() =>
      _BeneficiaryRequestScreenState();
}

class _BeneficiaryRequestScreenState extends State<BeneficiaryRequestScreen> {
  late var requests = [];

  track(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('rId', id);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TrackingScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchMyRequests();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchMyRequests() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var url = "$path/back_end/request/myRequest.php";

    final response = await http.post(Uri.parse(url),
        body: {'beneficiary': sharedPreferences.getString('uId').toString()});
    var requestList = json.decode(response.body);

    setState(() {
      requests = requestList as List;
    });
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
          name: 'My Request',
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Visibility(
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateRequestScreen()),
              );
            },
            backgroundColor: theme_color,
            label: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.add, size: 30, color: bg_color),
                ),
                Text(
                  "New Request",
                  style: TextStyle(
                      fontSize: 14,
                      color: bg_color,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
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
                  SizedBox(
                    height: screenHeight * 0.75,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: headingWidget(
                            heading: 'New Requests',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: DataTable(
                                columnSpacing: 18,
                                horizontalMargin: 5,
                                dataRowHeight: 30,
                                headingRowHeight: 70,
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Name',
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
                                        'Food',
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
                                          'Required Date',
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
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'Action',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: text_color_light,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: requests
                                    .map(
                                      (request) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(
                                            Container(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              child: Text(
                                                request['beneficiary']
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
                                              alignment:
                                                  AlignmentDirectional.center,
                                              child: Text(
                                                request['food'].toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: text_color_light,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Container(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              child: Text(
                                                request['count'].toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: text_color_light,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Container(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              child: Text(
                                                request['rDate'].toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: text_color_light,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Container(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              child: FittedBox(
                                                fit: BoxFit.fitWidth,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    track(request['ID']
                                                        .toString());
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              'Processing Data')),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ), backgroundColor: const Color.fromRGBO(
                                                            51, 86, 100, 1),
                                                  ),
                                                  child: const Text(
                                                    'Track',
                                                    style: TextStyle(
                                                        color: bg_color,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
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
