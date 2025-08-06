import 'package:flutter/material.dart';
import 'package:mindit/sqlite/model/base_model.dart';

class CustomTabController extends ModelBase {
  final TabController controller;
  CustomTabController({required this.controller});
}
