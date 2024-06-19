import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:db/service/ApiService.dart';
import 'package:db/weight/PagePublicWidget.dart';
import '../bean/ChapterResponse.dart';
import '../bean/PageResponseData.dart';

class PublicNumberItem extends StatefulWidget {
  const PublicNumberItem({super.key});

  @override
  State<PublicNumberItem> createState() => _PublicNumberItemState();
}

class _PublicNumberItemState extends State<PublicNumberItem> {
  late PageController _pageController;
  late ScrollController _scrollController;
  final List<String> _titles = [];
  final List<Widget> _children = [];
  bool _isLoading = true;
  bool _isError = false;
  bool _isDataLoaded = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _scrollController = ScrollController();
    if (!_isDataLoaded) {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    try {
      ChapterResponse fetchPagePublicNumberItemData =
      await ApiService().fetchPagePublicNumberItemData();
      if (fetchPagePublicNumberItemData.data.isNotEmpty) {
        setState(() {
          _titles.clear();
          _children.clear();
          for (var data in fetchPagePublicNumberItemData.data) {
            _titles.add(data.name);
            _children.add(PagePublicWidget(data));
          }
          _isDataLoaded = true;
          _isLoading = false;
          _isError = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _isError = true;
        });
      }
    } catch (e) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_isError) {
      return const Scaffold(
        body: Center(
          child: Text('Failed to load data'),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _titles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onButtonPressed(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    color: _selectedIndex == index
                        ? Colors.blue[200]
                        : Colors.teal[300],
                    child: Text(
                      _titles[index],
                      style: TextStyle(
                        color: _selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _children.length,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                _scrollToItem(index);
              },
              itemBuilder: (context, index) {
                return _children[index];
              },
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToItem(int index) {
    double offset =
    (index * 70.0).clamp(0.0, _scrollController.position.maxScrollExtent);
    _scrollController.animateTo(offset,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
