import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../const/app_constants.dart';

class HomeController extends GetxController {
  RxList<double> positionList = <double>[].obs;
  RxDouble bgWidth = 0.0.obs;
  RxBool isPanUp = false.obs;
  RxList<Widget> movableItems = <Widget>[].obs;

  setBgWidth(double width) {
    bgWidth.value = width;
  }

  updateIconPosition(int index) {
    for (int i = 0; i < positionList.length; i++) {
      if (i == index) {
        continue;
      }
      if (i < index) {
        positionList[i] = positionList[i] + 38;
      } else {
        positionList[i] = positionList[i] - 40;
      }
    }
  }

  resetPosition() {
    double defaultPosition = 0.0;
    for (int i = 0; i < positionList.length; i++) {
      if (i == 0) {
        defaultPosition = defaultPosition + xDefPosition;
      }
      positionList[i] = defaultPosition;
      defaultPosition = defaultPosition + 80.0;
    }
  }
}
