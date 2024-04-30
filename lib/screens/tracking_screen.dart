import 'dart:convert';
import 'package:feed_aid_app/constants.dart';
import 'package:feed_aid_app/screens/beneficiaryRequest_screen.dart';
import 'package:feed_aid_app/widgets/Footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../APIs/tracking/tracking-api.dart';
import '../APIs/tracking/tracking.dart';
import '../widgets/FormButton.dart';
import '../widgets/appBarWidget.dart';
import 'package:http/http.dart' as http;

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
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
          name: 'Tracking',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.845,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.29,
                      ),
                      FutureBuilder(
                        future: fetchTracking(),
                        builder:
                            (context, AsyncSnapshot<List<Tracking>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (BuildContext context, index) {
                                  Tracking track = snapshot.data![index];
                                  return trackingWidget(
                                      screenHeight: screenHeight,
                                      screenWidth: screenWidth,
                                      track: track);
                                });
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.085),
                  child: SizedBox(
                    height: screenHeight * 0.29,
                    child: Image.asset(
                      tracking_bg,
                      fit: BoxFit.fitHeight,
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

class trackingWidget extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final Tracking track;

  const trackingWidget(
      {Key? key,
      required this.screenHeight,
      required this.screenWidth,
      required this.track})
      : super(key: key);

  @override
  State<trackingWidget> createState() => _trackingWidgetState();
}

class _trackingWidgetState extends State<trackingWidget> {
  final _formKey = GlobalKey<FormBuilderState>();

  confirm() async {
    try {
      var url = "$path/back_end/request/confirm.php";

      final response = await http.post(Uri.parse(url), body: {
        'hID': widget.track.hid.toString(),
        'rID': widget.track.rid.toString(),
        'feedback': _formKey.currentState!.fields['feedback']!.value.toString()
      });
      var requestInfo = json.decode(response.body);

      if (requestInfo == "Success") {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Confirm Delivery",
          desc: "Delivery confirmed and Thank you for your valuable feedback.!",
          buttons: [
            DialogButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TrackingScreen()),
              ),
              width: 120,
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show().timeout(const Duration(seconds: 3));
      } else if (requestInfo == "Error") {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Error!",
          desc: "Please Contact the IT Department.....!",
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
        ).show().timeout(const Duration(seconds: 3));
      } else if (requestInfo == "not complete") {
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
      }
    } catch (e) {
      debugPrint("caught error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg_color,
      height: widget.screenHeight * 0.555,
      child: Column(children: [
        Stack(
          children: [
            SizedBox(
              height: widget.screenHeight * 0.36,
              child: Row(
                children: [
                  SizedBox(
                    height: widget.screenHeight * 0.35,
                    width: widget.screenWidth * 0.2,
                  ),
                  SizedBox(
                    height: widget.screenHeight * 0.36,
                    width: widget.screenWidth * 0.725,
                    child: Column(
                      children: [
                        if (widget.track.rStatus == 'Active') ...[
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            height: widget.screenHeight * 0.117,
                            child: const Text(
                              'Request has not been verified yet...!',
                              style: TextStyle(
                                  fontSize: 18, color: text_color_light),
                            ),
                          ),
                        ] else if (widget.track.rStatus == 'Approved' ||
                            widget.track.rStatus == 'Delivered') ...[
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            height: widget.screenHeight * 0.117,
                            child: Text.rich(
                              TextSpan(
                                text: 'Request Approved by ',
                                style: const TextStyle(
                                    fontSize: 18, color: text_color_light),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.track.donar,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: text_color_light,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            height: widget.screenHeight * 0.117,
                            width: widget.screenWidth * 0.725,
                            child: Text.rich(
                              TextSpan(
                                text: 'Food Picked up by ',
                                style: const TextStyle(
                                    fontSize: 18, color: text_color_light),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.track.volunteer,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: text_color_light,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const TextSpan(
                                    text: ' from store.',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: text_color_light,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (widget.track.rStatus == 'Delivered') ...[
                            Container(
                              alignment: AlignmentDirectional.centerStart,
                              height: widget.screenHeight * 0.117,
                              width: widget.screenWidth * 0.725,
                              child: const Text(
                                'Food Delivered.',
                                style: TextStyle(
                                    fontSize: 18, color: text_color_light),
                              ),
                            ),
                          ],
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (widget.track.rStatus == 'Active' ||
                widget.track.rStatus == 'Approved' ||
                widget.track.rStatus == 'Delivered') ...[
              Padding(
                padding: EdgeInsets.only(
                    left: widget.screenWidth * 0.03,
                    bottom: widget.screenWidth * 0.1),
                child: SizedBox(
                  height: widget.screenHeight * 0.3,
                  child: Image.asset(
                    tracking_status1,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              if (widget.track.rStatus == 'Approved' ||
                  widget.track.rStatus == 'Delivered') ...[
                Padding(
                  padding: EdgeInsets.only(
                      left: widget.screenWidth * 0.03,
                      bottom: widget.screenWidth * 0.1),
                  child: SizedBox(
                    height: widget.screenHeight * 0.3,
                    child: Image.asset(
                      tracking_status2,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                if (widget.track.rStatus == 'Delivered') ...[
                  Padding(
                    padding: EdgeInsets.only(
                        left: widget.screenWidth * 0.03,
                        bottom: widget.screenWidth * 0.1),
                    child: SizedBox(
                      height: widget.screenHeight * 0.3,
                      child: Image.asset(
                        tracking_status3,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ],
            ]
          ],
        ),
        Container(
          alignment: AlignmentDirectional.center,
          height: widget.screenHeight * 0.195,
          width: widget.screenWidth * 0.7,
          child: Stack(
            children: [
              if (widget.track.rStatus == 'Active') ...[
                FormButton(
                  execute: () async {
                    debugPrint("request id: ${widget.track.rid}");
                    var url = "$path/back_end/request/delete.php";

                    final response = await http.post(Uri.parse(url),
                        body: {'rID': widget.track.rid.toString()});
                    var requestInfo = json.decode(response.body);

                    try {
                      if (requestInfo == "Success") {
                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "Request Delete Process",
                          desc: "Request Deleted Successfully.....!",
                          buttons: [
                            DialogButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BeneficiaryRequestScreen()),
                              ),
                              width: 120,
                              child: const Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ],
                        ).show().timeout(const Duration(seconds: 3));
                      } else if (requestInfo == "Error") {
                        Alert(
                          context: context,
                          type: AlertType.error,
                          title: "Request Delete Attempt Failed!",
                          desc: "Please Contact the IT Department.....!",
                          buttons: [
                            DialogButton(
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                              child: const Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ],
                        ).show().timeout(const Duration(seconds: 3));
                      }
                    } catch (e) {
                      debugPrint("caught error: $e");
                    }
                  },
                  buttonColor: const Color.fromRGBO(194, 49, 47, 1),
                  buttonTextColor: text_color_dark,
                  buttonText: 'Delete Request',
                ),
              ] else if (widget.track.rStatus == 'Approved') ...[
                FormButton(
                  execute: () {
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
                                child: FormBuilderTextField(
                                  name: 'feedback',
                                  textAlign: TextAlign.left,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: bg_color,
                                    contentPadding: const EdgeInsets.only(
                                        left: 20, top: 10, bottom: 10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    hintText: 'Feedback',
                                    hintStyle: const TextStyle(
                                        color: text_color_light, fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        buttons: [
                          DialogButton(
                            radius: BorderRadius.circular(25.0),
                            onPressed: () {
                              confirm();
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: bg_color, fontSize: 20),
                            ),
                          )
                        ]).show();
                  },
                  buttonColor: const Color.fromRGBO(82, 177, 29, 1),
                  buttonTextColor: text_color_dark,
                  buttonText: 'Confirm Delivery',
                ),
              ],
            ],
          ),
        ),
      ]),
    );
  }
}
