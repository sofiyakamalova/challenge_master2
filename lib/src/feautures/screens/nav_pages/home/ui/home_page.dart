import 'package:challenge_master/src/core/common_widgets/common_app_bar.dart';
import 'package:challenge_master/src/core/common_widgets/common_widgets.dart';
import 'package:challenge_master/src/core/common_widgets/rounded_button.dart';
import 'package:challenge_master/src/feautures/screens/nav_pages/home/challenge_model/challenge_model.dart';
import 'package:challenge_master/src/feautures/screens/nav_pages/home/widgets/fortune_widget.dart';
import 'package:challenge_master/src/feautures/screens/nav_pages/home/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ChallengeModel>> _challengesFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _challengesFuture = getChallengesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Challenge Master',
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: SearchWidget(),
          ),
          const CommonTitle(
            title: 'Exhaust yourself with new challenges!',
            alignment: TextAlign.center,
            size: 25,
          ),
          const FortuneWidget(),
          const SizedBox(height: 10.0),
          Expanded(
            child: FutureBuilder<List<ChallengeModel>>(
              future: _challengesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<ChallengeModel> challenges = snapshot.data!;
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.maxFinite,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: const Border(
                              left: BorderSide(
                                color: Colors.amber,
                                width: 20.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  challenges[index].title ?? '',
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(width: 10),
                                    RoundedButton(),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
