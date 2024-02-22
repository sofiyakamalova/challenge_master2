import 'dart:math';

import 'package:challenge_master/src/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class WheelFortuneWidget extends StatelessWidget {
  final AnimationController animationController;
  final int winner;
  final Animation rotationTween;

  WheelFortuneWidget(
      {Key? key, required this.animationController, required this.winner})
      : rotationTween = Tween(
          begin: 0,
          end: 10 * 360 + 72 * winner.toDouble(),
        ).animate(CurvedAnimation(
            parent: animationController,
            curve: const Interval(0, 1, curve: Curves.decelerate))),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: const Image(
        width: 350,
        image: AssetImage('assets/images/wheel.png'),
      ),
      builder: (context, child) => Transform.rotate(
        angle: (rotationTween.value * pi) / 180,
        child: child,
      ),
    );
  }
}

class SpinningWheel extends StatefulWidget {
  const SpinningWheel({Key? key}) : super(key: key);

  @override
  State createState() => _SpinningWheelState();
}

class _SpinningWheelState extends State with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation rotationTween;
  int winner = Random().nextInt(5);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          winnerTag = "winner is $winner";
          _scaleDialog();
        });
      }
    });
  }

  Widget _dialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.whiteColor,
      title: const Center(
        child: Column(
          children: [
            Text(
              'GOOD LUCK, DEAR!',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
            Divider(
              height: 30,
              color: AppColor.secondMainColor,
            )
          ],
        ),
      ),
      content: Text(
        youWonFunction(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }

  String youWonFunction() {
    if (winner == 0) return 'You should read book';
    if (winner == 1) return 'You should play guitar 1 hour!!';
    if (winner == 2) return 'You should solve tasks from codeforce';
    if (winner == 3)
      return 'You should learn by heart the all poems of Pushkin ';
    return 'Today, you may relax :)';
  }

  void _scaleDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Card',
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: _dialog(ctx),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String winnerTag = "";

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return SizedBox(
      width: mediaQueryData.size.width,
      child: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.center,
                  children: [
                    WheelFortuneWidget(
                      animationController: _controller,
                      winner: winner,
                    ),
                    const Image(
                      width: 50,
                      image: AssetImage('assets/images/indicator.png'),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    if (_controller.isAnimating) return;
                    setState(() {
                      winner = Random().nextInt(5);
                      winnerTag = "";
                    });
                    _controller.reset();
                    _controller.forward().orCancel;
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      if (_controller.isAnimating) return;
                      setState(() {
                        winner = Random().nextInt(5);
                        winnerTag = "";
                      });
                      _controller.reset();
                      _controller.forward().orCancel;
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 100)),
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => _controller.isAnimating
                              ? const Color(0xFFEF6E1E)
                              : const Color(0xFFFF5200),
                        ),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        )),
                    child: const Text(
                      'PLAY',
                      style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
