import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingWebView extends StatefulWidget {
  final String url;
  const SettingWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<SettingWebView> createState() => SettingWebViewState();
}

class SettingWebViewState extends State<SettingWebView> {
  late WebViewController controller;

  //WebView ProgressBar
  final ValueNotifier<int> progress = ValueNotifier(0);

  //AppBarボタンの制御
  bool canGoBack = false;
  bool canGoForward = false;

  @override
  void initState() {
    super.initState();

    //WebViewの表示・遷移設定
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            this.progress.value = progress;
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            //外部のページには遷移しない
            if (!request.url.startsWith('https://mathpire.studio.site/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () async {
              await controller.canGoBack() ? controller.goBack() : null;
            },
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () async {
              await controller.canGoForward() ? controller.goForward() : null;
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            onPressed: () {
              controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ValueListenableBuilder<int>(
              valueListenable: progress,
              builder: (context, value, _) {
                return Visibility(
                  visible: value != 100,
                  child: SizedBox(
                    height: 5,
                    width: MediaQuery.of(context).size.width,
                    child: LinearProgressIndicator(
                      value: value / 100,
                      backgroundColor: Colors.transparent,
                      color: Colors.blue,
                    ),
                  ),
                );
              }),
          WebViewWidget(controller: controller),
        ],
      ),
    );
  }
}
