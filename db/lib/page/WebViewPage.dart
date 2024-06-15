import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  WebViewPage({
    super.key,
    required this.title,
    required this.url,
  }){
    print("zhy^_^ " + url + "---" + title);
  }

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;
  bool _isLoading = true;
  String _pageTitle = '';

  @override
  void initState() {
    super.initState();
    // Enable JavaScript in WebView
    WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle.isEmpty ? widget.title : _pageTitle),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (String url) {
              setState(() {
                _isLoading = true;
              });
              _updatePageTitle('');
            },
            onPageFinished: (String url) {
              _controller.runJavascriptReturningResult('document.title').then((
                  title) {
                _updatePageTitle(title);
              }).catchError((error) {
                debugPrint('Failed to get title: $error');
                _updatePageTitle('Failed to load');
              }).whenComplete(() {
                setState(() {
                  _isLoading = false;
                });
              });
            },
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  void _updatePageTitle(String title) {
    setState(() {
      _pageTitle = title;
    });
  }
}
