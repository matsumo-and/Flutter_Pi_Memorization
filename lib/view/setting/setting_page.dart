import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';
import 'package:flutter_pi_memorization/view/setting/privacy_policy.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

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
              height: 50,
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.lock),
                    SizedBox(width: 10),
                    Text('プライバシーポリシーを見る'),
                  ],
                ),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyView()))),
        ],
      )),
    );
  }
}
