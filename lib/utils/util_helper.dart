import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../main.dart';

class UtilHelper {
  static double getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(context) {
    return MediaQuery.of(context).size.width;
  }
}
