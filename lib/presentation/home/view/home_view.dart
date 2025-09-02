import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/presentation/app_drawer/app_drawer.dart';
import '/core/animation/view/animated_bg_builder.dart';
import '/core/global_keys/global_key.dart';
import '../controller/home_controller.dart';
import 'widgets/home_body.dart';
import '/core/utils/home_dialog.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    Get.find<HomeController>().requestTrackingPermission();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, value) async {
        if (didPop) return;
        final shouldExit = await HomeDialogs.showExitDialog(context);
        if (shouldExit == true) SystemNavigator.pop();
      },
      child: Scaffold(
        key: globalDrawerKey,
        drawer: const AppDrawer(),
        onDrawerChanged: (isOpen) {
          homeController.isDrawerOpen.value = isOpen;
        },
        body: Stack(
          children: [
            AnimatedBgImageBuilder(),
            const SafeArea(child: HomeBody()),
          ],
        ),
      ),
    );
  }
}
