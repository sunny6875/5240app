import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthTabController extends GetxController {
  late TabController _tabController;

  void setTabController(TabController tabController) {
    _tabController = tabController;
  }

  void setPageIndex(int index) {
    _tabController.index = index;
    debugPrint("TbaController==============${_tabController.index}");
  }
}
