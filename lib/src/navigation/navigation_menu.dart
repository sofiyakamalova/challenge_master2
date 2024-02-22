import 'package:challenge_master/src/core/constants/app_color.dart';
import 'package:challenge_master/src/feautures/screens/nav_pages/home/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.grid_view_rounded,
                  color: AppColor.secondMainColor,
                ),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(
                  color: AppColor.secondMainColor,
                  Icons.library_add_check_rounded,
                ),
                label: 'Progress'),
            NavigationDestination(
                icon: Icon(
                  Icons.menu,
                  color: AppColor.secondMainColor,
                ),
                label: 'Settings'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomePage(),
    Container(color: Colors.yellowAccent),
    Container(color: Colors.blue),
  ];
}
