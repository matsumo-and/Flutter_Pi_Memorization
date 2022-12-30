import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyView> createState() => PrivacyPolicyViewState();
}

class PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (!request.url.startsWith('https://mathpire.studio.site/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://mathpire.studio.site/'));

  @override
  Widget build(BuildContext context) {
    print(controller.currentUrl());
    return Scaffold(
      appBar: AppBar(title: Text('web')),
      body: WebViewWidget(controller: controller),
    );
  }
}
