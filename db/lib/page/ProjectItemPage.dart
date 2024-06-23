import 'package:flutter/material.dart';
import 'package:db/service/ApiService.dart';
import '../bean/ChapterResponse.dart';
import '../weight/FullScreenDraggableButton.dart';
import 'ProjectArticleCardPage.dart';

class ProjectPageItem extends StatefulWidget {
  const ProjectPageItem({Key? key}) : super(key: key);

  @override
  _ProjectPageItemState createState() => _ProjectPageItemState();
}

class _ProjectPageItemState extends State<ProjectPageItem> {
  List<Chapter> chapters = [];
  List<Widget> pageList = [];
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    fetchData(); // Start fetching data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Chapter>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          chapters = snapshot.data!;
          // Build the pageList once data is fetched
          pageList = chapters
              .map((chapter) => ProjectArticleCardPage(chapter))
              .toList();
          return Stack(
            children: [
              PageView(
                controller: pageController,
                children: pageList,
                onPageChanged: (int index) {
                },
              ),
              FloatingMenu(chapters, handleButtonClick),
            ],
          );
        }
      },
    );
  }

  Future<List<Chapter>> fetchData() async {
    try {
      var fetchPageSysItemData = await ApiService().fetchPageProjectItemData();
      if (fetchPageSysItemData.data.isNotEmpty) {
        return fetchPageSysItemData.data;
      } else {
        return []; // or handle empty case as needed
      }
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
