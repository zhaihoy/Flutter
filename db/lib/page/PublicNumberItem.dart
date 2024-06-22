import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:db/service/ApiService.dart';
import 'package:db/weight/PagePublicWidget.dart';
import '../bean/ChapterResponse.dart';
import '../bean/PageResponseData.dart';

class PublicNumberItem extends StatefulWidget {
  final List<String> _titles = [];
  final List<Widget> _children = [];
  bool _isLoading = true;
  bool _isError = false;
  bool _isDataLoaded = false;
  int _selectedIndex = 0;
  Map<int, ChapterResponse> _cache = {};

  PublicNumberItem({super.key});

  @override
  State<PublicNumberItem> createState() => _PublicNumberItemState();
}

class _PublicNumberItemState extends State<PublicNumberItem>
    with AutomaticKeepAliveClientMixin {
  // Cache map to store fetched data
  late PageController _pageController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget._selectedIndex);
    _scrollController = ScrollController();
    if (!widget._isDataLoaded) {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    try {
      // Check if data is cached
      if (widget._cache.containsKey(widget._selectedIndex)) {
        if(widget._cache[widget._selectedIndex]==null){
          print("zhy^_^ "+widget._selectedIndex.toString());
        }else{
          setState(() {
            _updateUIWithCachedData(widget._selectedIndex);
          });
        }
      } else {
        // Fetch data from network if not cached
        ChapterResponse fetchPagePublicNumberItemData =
            await ApiService().fetchPagePublicNumberItemData();
        if (fetchPagePublicNumberItemData.data.isNotEmpty) {
          setState(() {
            widget._cache[widget._selectedIndex] =
                fetchPagePublicNumberItemData;
            _updateUIWithCachedData(widget._selectedIndex);
          });
        } else {
          setState(() {
            widget._isLoading = false;
            widget._isError = true;
          });
        }
      }
    } catch (e) {
      setState(() {
        widget._isError = true;
        widget._isLoading = false;
      });
    }
  }

  // Method to update UI with cached data
  void _updateUIWithCachedData(int index) {
    var cachedData = widget._cache[index]!;
    widget._titles.clear();
    widget._children.clear();
    for (var data in cachedData.data) {
      widget._titles.add(data.name);
      widget._children.add(PagePublicWidget(data));
    }
    widget._isDataLoaded = true;
    widget._isLoading = false;
    widget._isError = false;
  }

  @override
  void dispose() {
    print('zhy _PublicNumberItemState.dispose');
    // _pageController.dispose();
    // _scrollController.dispose();
    super.dispose();
  }

  void _onButtonPressed(int index) {
    setState(() {
      widget._selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _scrollToItem(int index) {
    double offset =
        (index * 70.0).clamp(0.0, _scrollController.position.maxScrollExtent);
    _scrollController.animateTo(offset,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    if (widget._isError) {
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
              itemCount: widget._titles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onButtonPressed(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    color: widget._selectedIndex == index
                        ? Colors.blue[200]
                        : Colors.teal[300],
                    child: Text(
                      widget._titles[index],
                      style: TextStyle(
                        color: widget._selectedIndex == index
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
              itemCount: widget._children.length,
              onPageChanged: (index) {
                setState(() {
                  widget._selectedIndex = index;
                });
                _scrollToItem(index);
              },
              itemBuilder: (context, index) {
                return widget._children[index];
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
