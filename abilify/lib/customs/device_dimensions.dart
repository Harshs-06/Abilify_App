import 'package:flutter/material.dart';

List<double> getDevice_wh(BuildContext context) {
  final deviceWidth = MediaQuery.of(context).size.width;
  final deviceHeight = MediaQuery.of(context).size.height;
  return [deviceWidth, deviceHeight];
}