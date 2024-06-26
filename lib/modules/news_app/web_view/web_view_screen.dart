import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';



class WebViewScreen extends StatelessWidget {

  final String url;

  const WebViewScreen(this.url);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebViewWidget(
       controller: WebViewController()..loadRequest(
         Uri.parse(url),
       ),
  ),
    );
  }
}


