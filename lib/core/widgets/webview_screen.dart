import 'package:flutter/material.dart';
import 'package:ballaghny/core/utils/media_query_values.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/assets_manager.dart';

class WebviewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebviewScreen({super.key, required this.url, required this.title});

  @override
  _WebviewScreenState createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: context.height * 0.2,
          leading: null,
          title: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset(AppAssets.logo),
          ),
        ),
        body: WebViewWidget(
            controller: WebViewController()
              ..loadRequest(Uri.parse(widget.url))));
  }
}
