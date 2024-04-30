import 'dart:convert';
import 'package:feed_aid_app/constants.dart';
import 'package:feed_aid_app/widgets/Footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/appBarWidget.dart';
import '../widgets/headingWidgets.dart';
import 'package:http/http.dart' as http;

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late var newRequests = [];
  late var requestHistory = [];
  late var volunteerList = [];

  late String requestID;

  @override
  void initState() {
    super.initState();
    fetchNewRequests();
    fetchRequestsHistory();
    fetchVolunteer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchNewRequests() async {
    var url = "$path/back_end/request/newRequest.php";

    final response = await http.get(Uri.parse(url));
    var requestList = json.decode(response.body);

    setState(() {
      newRequests = requestList as List;
    });
  }

  fetchRequestsHistory() async {
    var url = "$path/back_end/request/view.php";

    final response = await http.get(Uri.parse(url));
    var requestList = json.decode(response.body);

    setState(() {
      requestHistory = requestList as List;
    });
  }

  fetchVolunteer() async {
    var url = "$path/back_end/volunteer/view.php";

    final response = await http.get(Uri.parse(url));
    var volunteerData = json.decode(response.body);

    setState(() {
      volunteerList = volunteerData as List;
    });
  }

  requestHandling(String volunteerID) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    var url = "$path/back_end/request/approveRequest.php";

    final response = await http.post(Uri.parse(url), body: {
      'dID': sharedPreferences.getString('uId').toString(),
      'rID': requestID,
      'volunteer': volunteerID,
    });
    var requestHandle = json.decode(response.body);

    try {
      if (requestHandle == "Success") {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Approve Request",
          desc: "Request Approved Successfully.....!",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RequestScreen()),
              ),
              width: 120,
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show().timeout(const Duration(seconds: 3));
      } else if (requestHandle == "Error") {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Error",
          desc: "Please contact the IT Department.....!",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show().timeout(const Duration(seconds: 5));
      }
    } catch (e) {
      debugPrint("Caught Error: $e");
    }
  }

  approve(String id) {
    setState(() {
      requestID = id;
    });
    Alert(
        context: context,
        style: const AlertStyle(
          backgroundColor: Color.fromRGBO(51, 86, 100, 1),
        ),
        content: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: bg_color,
                border: Border.all(
                  color: theme_color,
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: FormBuilder(
                key: _formKey,
                child: FormBuilderDropdown<String>(
                  name: 'volunteer',
                  alignment: AlignmentDirectional.centerStart,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    hintText: 'Volunteer',
                    hintStyle: TextStyle(fontSize: 16, color: text_color_light),
                  ),
                  items: volunteerList
                      .map(
                        (volunteer) => DropdownMenuItem(
                          value: volunteer['V_id'].toString(),
                          child: Text(
                            volunteer['V_name'].toString(),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
        buttons: [
          DialogButton(
            radius: BorderRadius.circular(25.0),
            onPressed: () {
              requestHandling(
                  _formKey.currentState!.fields['volunteer']!.value.toString());
              fetchNewRequests();
              fetchRequestsHistory();
              Navigator.pop(context);
            },
            child: const Text(
              "Confirm",
              style: TextStyle(color: bg_color, fontSize: 20),
            ),
          )
        ]).show();
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
          name: 'Request List',
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
                    height: screenHeight * 0.375,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: headingWidget(
                            heading: 'New Requests',
                          ),
                        ),
                        Container(
                          height: screenHeight * 0.27,
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
                                rows: newRequests
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
                                                    approve(request['ID']
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
                                                    'Approve',
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
                  SizedBox(
                    height: screenHeight * 0.47,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: headingWidget(
                            heading: 'Request History',
                          ),
                        ),
                        Container(
                          height: screenHeight * 0.365,
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
                                      child: Text(
                                        'Requested Date',
                                        softWrap: true,
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
                                ],
                                rows: requestHistory
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
                                                request['reqDate'].toString(),
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
