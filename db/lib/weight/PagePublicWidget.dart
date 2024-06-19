import 'package:db/bean/ChapterResponse.dart';
import 'package:db/service/ApiService.dart';
import 'package:db/weight/ArticleCard.dart';
import 'package:flutter/material.dart';
import '../bean/PageResponseData.dart';

class PagePublicWidget extends StatefulWidget {
  final Chapter data;

  const PagePublicWidget(this.data);

  @override
  State<PagePublicWidget> createState() => _PagePublicWidgetState();
}

class _PagePublicWidgetState extends State<PagePublicWidget> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 0;
  List<Article> items = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchMoreData();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchMoreData();
    }
  }

  Future<void> _fetchMoreData() async {
    if (_loading) return;

    setState(() {
      _loading = true;
    });

    try {
      var fetchArticleResponse =
          await ApiService().fetchArticleResponse(widget.data.id, currentPage);
      setState(() {
        var newData = fetchArticleResponse.data.datas;
        items.addAll(newData);
        currentPage++;
        _loading = false;
      });
    } catch (e) {
      // Handle error, e.g., show error message
      print('Error fetching data: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: items.length + 1, // +1 for loading indicator
            itemBuilder: (context, index) {
              if (index < items.length) {
                return ArticleCard(items[index]);
              } else {
                return _buildProgressIndicator();
              }
            },
          ),
        ),
        if (_loading) _buildProgressIndicator(),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
