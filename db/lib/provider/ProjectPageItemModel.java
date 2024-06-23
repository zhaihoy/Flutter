import 'package:flutter/material.dart';
import 'package:db/service/ApiService.dart';
import 'package:db/bean/ChapterResponse.dart';

class ProjectPageItemModel extends ChangeNotifier {
  List<Chapter> _chapters = [];
  int _selectedIndex = 0;

  List<Chapter> get chapters => _chapters;

  int get selectedIndex => _selectedIndex;

  PageController pageController = PageController();

  ProjectPageItemModel() {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var fetchPageSysItemData = await ApiService().fetchPageProjectItemData();
      if (fetchPageSysItemData.data.isNotEmpty) {
        _chapters = fetchPageSysItemData.data;
        notifyListeners(); // Notify listeners upon data change
      } else {
        _chapters = [];
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void handleButtonClick(int index) {
    _selectedIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    notifyListeners(); // Notify listeners upon selectedIndex change
  }
}
