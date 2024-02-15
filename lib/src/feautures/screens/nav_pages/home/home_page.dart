import 'package:challenge_master/src/core/common_widgets/common_app_bar.dart';
import 'package:challenge_master/src/core/common_widgets/common_widgets.dart';
import 'package:challenge_master/src/feautures/screens/nav_pages/home/widgets/fortune_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Challenge Master',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonTitle(
              title: 'Exhaust yourself with new challenges!',
              alignment: TextAlign.center,
              size: 25,
            ),
          ),
          FortuneWidget(),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
