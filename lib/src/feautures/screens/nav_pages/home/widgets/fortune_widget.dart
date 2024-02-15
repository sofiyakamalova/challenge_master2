import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';

class FortuneWidget extends GetView<FortuneController> {
  const FortuneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(FortuneController());
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 330,
        child: FortuneWheel(
          onAnimationEnd: () {
            c.showDialog();
          },
          selected: c.streamController.stream,
          animateFirst: false,
          indicators: const [
            FortuneIndicator(
                child: Icon(
              Icons.circle,
              color: Colors.white,
              size: 60,
            )),
            FortuneIndicator(
              alignment: Alignment.centerRight,
              child: TriangleIndicator(
                color: Colors.deepOrangeAccent,
                width: 50,
                height: 50,
              ),
            ),
          ],
          physics: CircularPanPhysics(
            duration: const Duration(seconds: 1),
            curve: Curves.easeOutExpo,
          ),
          onFling: () {
            c.spinthewheel();
          },
          items: [...c.items],
        ),
      ),
    );
  }
}

class FortuneController extends GetxController {
  Rx<int> streamController = 0.obs;

  final List<FortuneItem> items = [
    FortuneItem(
      child: Text('Item 1'),
      style: FortuneItemStyle(
        color: Colors.red,
        borderColor: Colors.transparent,
        textStyle: TextStyle(color: Colors.transparent),
      ),
    ),
    FortuneItem(
      child: Text('Item 2'),
      style: FortuneItemStyle(
        color: Colors.blue,
        borderColor: Colors.transparent,
        textStyle: TextStyle(color: Colors.transparent),
      ),
    ),
    FortuneItem(
      child: Text('Item 2'),
      style: FortuneItemStyle(
        color: Colors.pink,
        borderColor: Colors.transparent,
        textStyle: TextStyle(color: Colors.transparent),
      ),
    ),
    FortuneItem(
      child: Text('Item 2'),
      style: FortuneItemStyle(
        color: Colors.yellow,
        borderColor: Colors.transparent,
        textStyle: TextStyle(color: Colors.transparent),
      ),
    ),
    FortuneItem(
      child: Text('Item 2'),
      style: FortuneItemStyle(
        color: Colors.green,
        borderColor: Colors.transparent,
        textStyle: TextStyle(color: Colors.transparent),
      ),
    ),
  ];

  showDialog() {
    Get.defaultDialog(
      title: 'Congratulatios',
    );
  }

  spinthewheel() {
    streamController.value = Fortune.randomInt(0, items.length);
    print(streamController.value);
  }

  @override
  void onClose() {
    super.onClose();
    streamController.close();
  }
}
