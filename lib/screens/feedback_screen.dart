import 'package:feed_aid_app/constants.dart';
import 'package:feed_aid_app/widgets/Footer.dart';
import 'package:flutter/material.dart';
import '../APIs/feedback/feedback-api.dart';
import '../APIs/feedback/feedback.dart';
import '../widgets/appBarWidget.dart';

import '../widgets/feedbackWidgets.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  void initState() {
    super.initState();
    fetchFeedback();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bg_color,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: appbarWidget(
          name: 'Feedbacks',
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.845,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder(
                      future: fetchFeedback(),
                      builder: (context,
                          AsyncSnapshot<List<FeedbackList>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, index) {
                                FeedbackList feedBack = snapshot.data![index];
                                return feedbackWidget(
                                  fBack: feedBack,
                                );
                              });
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const footer(),
        ],
      ),
    );
  }
}
