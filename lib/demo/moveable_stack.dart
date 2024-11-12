import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/controller/home_controller.dart';
import 'package:untitled/utils/util_helper.dart';

import '../const/app_constants.dart';

class MoveableStackItem extends StatefulWidget {
  double defaultPosition;
  int index;

  MoveableStackItem({super.key, required this.defaultPosition, required this.index});

  @override
  State<StatefulWidget> createState() {
    return _MoveableStackItemState();
  }
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  final HomeController homeController = Get.find();
  double xPosition = xDefPosition;
  double yPosition = 0;
  late Color color;
  double counter = 0;

  bool isUpdateCalled = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      yPosition = UtilHelper.getHeight(context) - 100;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('position[${widget.index}]: ${homeController.positionList[widget.index] + xPosition}');
    return Obx(() => AnimatedPositioned(
          left: homeController.positionList[widget.index] + xPosition,
          // widget.defaultPosition + xPosition,
          duration: Duration(milliseconds: homeController.isPanUp.value ? 100 : 300),
          top: yPosition,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onPanUpdate: (tapInfo) {
                print('onPanUpdate');

                if ((UtilHelper.getHeight(context) - 185) > yPosition) {
                  if (!isUpdateCalled) {
                    homeController.updateIconPosition(widget.index);
                  }
                  isUpdateCalled = true;
                  homeController.bgWidth.value = UtilHelper.getWidth(context) - 60;
                } else if ((UtilHelper.getHeight(context) - 125) < yPosition) {
                  // homeController.updateIconPosition(widget.index);
                  homeController.bgWidth.value = UtilHelper.getWidth(context);
                }
                // homeController.bgWidth.value = homeController.bgWidth.value - counter;
                homeController.isPanUp.value = true;
                setState(() {
                  xPosition += tapInfo.delta.dx;
                  yPosition += tapInfo.delta.dy;
                });
              },
              onPanEnd: (tapInfo) {
                counter = 0;
                homeController.setBgWidth(UtilHelper.getWidth(context));
                xPosition = xDefPosition;
                yPosition = UtilHelper.getHeight(context) - 100;
                homeController.isPanUp.value = false;
                homeController.resetPosition();
                isUpdateCalled = false;
                setState(() {});
              },
              onPanStart: (tapInfo) {
                print('onPanStart');
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.8), borderRadius: BorderRadius.circular(12)),
                child: const Icon(
                  Icons.abc_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ));
  }
}
