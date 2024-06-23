import 'package:db/bean/ChapterResponse.dart';
import 'package:db/service/ApiService.dart';
import 'package:db/weight/ArticleCard.dart';
import 'package:flutter/material.dart';
import '../bean/PageResponseData.dart';

class PagePublicWidget extends StatefulWidget {
  final Chapter data;
  List<Article> items = [];
  int currentPage = 1;
  bool _loading = false;

  PagePublicWidget(this.data);

  @override
  State<PagePublicWidget> createState() => _PagePublicWidgetState();
}

class _PagePublicWidgetState extends State<PagePublicWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.items.isEmpty) {
      _fetchMoreData();
    }
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
    if (widget._loading) return;

    setState(() {
      widget._loading = true;
    });

    try {
      var fetchArticleResponse = await ApiService()
          .fetchArticleResponse(widget.data.id, widget.currentPage);
      setState(() {
        var newData = fetchArticleResponse.data.datas;
        widget.items.addAll(newData);
        widget.currentPage++;
        widget._loading = false;
      });
    } catch (e) {
      // Handle error, e.g., show error message
      print('zhy Error >>>  $e');
      setState(() {
        widget._loading = false;
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
            itemCount: widget.items.length + 1, // +1 for loading indicator
            itemBuilder: (context, index) {
              if (index < widget.items.length) {
                return ArticleCard(widget.items[index]);
              } else {
                return _buildProgressIndicator();
              }
            },
          ),
        ),
        if (widget._loading) _buildProgressIndicator(),
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
