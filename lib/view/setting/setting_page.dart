import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';
import 'package:flutter_pi_memorization/view/setting/web_view.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  static const double _height = 50;
  static const EdgeInsets _margin = EdgeInsets.fromLTRB(15, 15, 15, 0);
  static const EdgeInsets _padding = EdgeInsets.all(10);

  String _version = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getVersion());
  }

  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          TappableCard(
              height: _height,
              margin: _margin,
              child: Padding(
                padding: _padding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_outline),
                    SizedBox(width: _padding.bottom),
                    const Text('プライバシーポリシー'),
                  ],
                ),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const SettingWebView(
                        url: 'https://mathpire.studio.site/privacy-policy',
                      )))),
          TappableCard(
              height: _height,
              margin: _margin,
              child: Padding(
                padding: _padding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.mail_outline),
                    SizedBox(width: _padding.bottom),
                    const Text('コンタクト'),
                  ],
                ),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const SettingWebView(
                        url: 'https://mathpire.studio.site/contact',
                      )))),
          TappableCard(
              height: _height,
              margin: _margin,
              child: Padding(
                padding: _padding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.info_outline),
                    SizedBox(width: _padding.bottom),
                    const Text('Mathpireについて'),
                  ],
                ),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const SettingWebView(
                        url: 'https://mathpire.studio.site/',
                      )))),
          const SizedBox(height: 15),
          Text('Mathpire Ver$_version'),
          const SizedBox(height: 15),
          const Text('Copyright © 2023 SpiralLab, Inc. All right reserved.'),
        ],
      )),
    );
  }
}
