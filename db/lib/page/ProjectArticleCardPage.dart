import 'package:flutter/material.dart';
import 'package:db/bean/ChapterResponse.dart';
import 'package:db/bean/PageResponseData.dart';
import 'package:db/service/ApiService.dart';
import 'package:db/weight/ProjectArticleCardItem.dart';

class ProjectArticleCardPage extends StatefulWidget {
  final Chapter chapter;

  ProjectArticleCardPage(this.chapter, {Key? key}) : super(key: key);

  @override
  _ProjectArticleCardPageState createState() => _ProjectArticleCardPageState();
}

class _ProjectArticleCardPageState extends State<ProjectArticleCardPage>
    with AutomaticKeepAliveClientMixin {
  int currentPage = 0;
  List<Article> data = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch initial data when widget initializes
    // Add listener to fetch more data when reaching the end of list
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose(); // Dispose scroll controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshData,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ProjectArticleCardItem(data[index]);
        },
        itemCount: data.length,
        controller: scrollController,
      ),
    );
  }

  Future<void> refreshData() async {
    setState(() {
      currentPage = 0;
      data.clear();
    });
    await fetchData();
  }

  Future<void> fetchData() async {
    try {
      var fetchPageProjectItemData =
          await ApiService().fetchData(currentPage, widget.chapter.id);
      var newData = fetchPageProjectItemData.data.datas;
      setState(() {
        data.addAll(newData);
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error gracefully, e.g., show a snackbar or retry logic
    }
  }

  Future<void> fetchNextPage() async {
    currentPage++;
    await fetchData();
  }

  @override
  bool get wantKeepAlive => true;
}
