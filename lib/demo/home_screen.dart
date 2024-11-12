import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/home_controller.dart';
import 'package:untitled/utils/util_helper.dart';
import '../const/app_constants.dart';
import 'moveable_stack.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  double defaultPosition = 0.0;
  late Color color;
  bool loading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      homeController.setBgWidth(UtilHelper.getWidth(context));
      setPosition();
    });
    // TODO: implement initState
    super.initState();
  }

  setPosition() {
    for (int i = 0; i < 5; i++) {
      homeController.positionList.add(defaultPosition + xDefPosition);
      homeController.movableItems.add(MoveableStackItem(
        defaultPosition: defaultPosition,
        index: homeController.movableItems.length,
      ));
      defaultPosition = defaultPosition + 80.0;
    }
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: loading
              ? Align(alignment: Alignment.center, child: const CircularProgressIndicator())
              : Obx(() => Container(
                    alignment: Alignment.bottomCenter,
                    height: UtilHelper.getHeight(context),
                    width: UtilHelper.getWidth(context),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: bgContainer(),
                        ),
                        for (int i = 0; i < homeController.movableItems.length; i++) ...[
                          homeController.movableItems[i],
                        ],
                      ],
                    ),
                  ))),
    );
  }

  bgContainer() => Obx(() => AnimatedContainer(
        duration: Duration(milliseconds: homeController.isPanUp.value ? 100 : 300),
        margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(12)),
        width: homeController.bgWidth.value,
        height: 90.0,
      ));
}
