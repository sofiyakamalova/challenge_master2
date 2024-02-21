import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';

class FortuneWidget extends GetView<FortuneController> {
  const FortuneWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(FortuneController());
    return SizedBox(
      height: 250,
      child: GestureDetector(
        onTap: () {
          c.spinthewheel();
        },
        child: FortuneWheel(
          onAnimationEnd: () {
            if (c.isAnimationStopped()) {
              c.showDialog();
            }
          },
          physics: CircularPanPhysics(
            duration: const Duration(seconds: 3),
            curve: Curves.easeOutExpo,
          ),
          selected: c.streamController.stream,
          animateFirst: false,
          indicators: [
            FortuneIndicator(
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepOrangeAccent, Colors.yellow],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const FortuneIndicator(
              alignment: Alignment.centerRight,
              child: TriangleIndicator(
                color: Colors.deepOrange,
                width: 30,
                height: 30,
              ),
            ),
          ],
          items: [...c.items],
        ),
      ),
    );
  }
}

class FortuneController extends GetxController {
  Rx<int> streamController = 0.obs;
  int? initialPosition;

  final List<FortuneItem> items = [
    // Ваш список элементов
    FortuneItem(
      child: Text('Item 2'),
      style: FortuneItemStyle(
        color: Colors.pink,
        borderColor: Colors.amber,
        borderWidth: 7,
        textStyle: TextStyle(color: Colors.transparent),
      ),
    ),
    FortuneItem(
      child: Text('Item 2'),
      style: FortuneItemStyle(
        color: Colors.blueAccent,
        borderColor: Colors.amber,
        borderWidth: 7,
        textStyle: TextStyle(color: Colors.transparent),
      ),
    ),
    FortuneItem(
      child: Text('Item 2'),
      style: FortuneItemStyle(
        color: Colors.blue.shade100,
        borderColor: Colors.amber,
        borderWidth: 7,
        textStyle: TextStyle(color: Colors.transparent),
      ),
    ),
    FortuneItem(
      child: Text('Item 2'),
      style: FortuneItemStyle(
        color: Colors.green,
        borderColor: Colors.amber,
        borderWidth: 7,
        textStyle: TextStyle(color: Colors.transparent),
      ),
    ),
    FortuneItem(
      child: Text('Item 2'),
      style: FortuneItemStyle(
        color: Colors.cyan,
        borderColor: Colors.amber,
        borderWidth: 7,
        textStyle: TextStyle(color: Colors.transparent),
      ),
    ),
    FortuneItem(
      child: Text('Item 2'),
      style: FortuneItemStyle(
        color: Colors.deepOrangeAccent,
        borderColor: Colors.amber,
        borderWidth: 7,
        textStyle: TextStyle(color: Colors.transparent),
      ),
    ),
  ];

  showDialog() {
    Get.defaultDialog(
      title: 'Congratulations',
    );
  }

  spinthewheel() {
    streamController.value = Fortune.randomInt(0, items.length);
    initialPosition = streamController.value;
  }

  bool isAnimationStopped() {
    return initialPosition == streamController.value;
  }

  @override
  void onClose() {
    super.onClose();
    streamController.close();
  }
}
