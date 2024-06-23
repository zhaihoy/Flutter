import 'package:flutter/material.dart';
import 'package:db/service/ApiService.dart';
import '../bean/ChapterResponse.dart';
import '../weight/FullScreenDraggableButton.dart';
import 'ProjectArticleCardPage.dart';

class ProjectPageItem extends StatefulWidget {
  ProjectPageItem({Key? key}) : super(key: key);

  @override
  _ProjectPageItemState createState() => _ProjectPageItemState();
}

class _ProjectPageItemState extends State<ProjectPageItem> {
  int currentPageIndex = 0;
  late Future<List<Chapter>> _fetchDataFuture;

  List<Widget> pageList = [];
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = fetchData();
  }

  void onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chapter>>(
      future: _fetchDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          var chapters = snapshot.data!;
          pageList = chapters.map((chapter) => ProjectArticleCardPage(chapter)).toList();

          return Stack(
            children: [
              PageView(
                controller: pageController,
                children: pageList,
                onPageChanged: onPageChanged,
              ),
              FloatingMenu(
                chapters: chapters,
                handleButtonClick: handleButtonClick,
                currentPageIndex: currentPageIndex,
              ),
            ],
          );
        }
      },
    );
  }

  Future<List<Chapter>> fetchData() async {
    try {
      var fetchPageSysItemData = await ApiService().fetchPageProjectItemData();
      return fetchPageSysItemData.data.isNotEmpty ? fetchPageSysItemData.data : [];
    } catch (e) {
      print('Error fetching data: $e');
      throw e;
    }
  }

  void handleButtonClick(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
