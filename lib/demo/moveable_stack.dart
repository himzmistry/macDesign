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
      yPosition = UtilHelper.getHeight(context) - yDefPosition;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('height: ${UtilHelper.getHeight(context)}');
    print('width: ${UtilHelper.getWidth(context)}');
    return Obx(() => AnimatedPositioned(
          left: homeController.positionList[widget.index] + xPosition,
          // widget.defaultPosition + xPosition,
          duration: Duration(milliseconds: homeController.isPanUp.value ? 100 : 300),
          top: yPosition,
          child: GestureDetector(
            onPanUpdate: (tapInfo) {
              if ((UtilHelper.getHeight(context) - 185) > yPosition) {
                if (!isUpdateCalled) {
                  homeController.updateIconPosition(widget.index);
                }
                isUpdateCalled = true;
                homeController.bgWidth.value = bgContainerWidth - bgContainerOffset;
              } else if ((UtilHelper.getHeight(context) - 125) < yPosition) {
                // homeController.updateIconPosition(widget.index);
                // homeController.bgWidth.value = bgContainerWidth;
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
              homeController.setBgWidth(bgContainerWidth);
              xPosition = xDefPosition;
              yPosition = UtilHelper.getHeight(context) - yDefPosition;
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
        ));
  }
}
