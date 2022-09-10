import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/model/tab.dart';
import 'package:flutter_pi_memorization/view/multiplication.dart';
import 'package:flutter_pi_memorization/view/pi_memorization.dart';
import 'package:flutter_pi_memorization/view/progress_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomTabBar extends ConsumerStatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends ConsumerState<BottomTabBar> {
  late CupertinoTabController _controller;

  final List<Tabs> _tabsList = [
    const Tabs(Multiprication(), "掛け算", Icon(Icons.close)),
    const Tabs(PiMemorization(), "円周率", Icon(Icons.close)),
    const Tabs(ProgressRecord(), "記録", Icon(Icons.close)),
  ];

  List<GlobalKey<NavigatorState>> _globalKeyList = [];
  int exSelectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = CupertinoTabController();
    _globalKeyList =
        List.generate(_tabsList.length, (num) => GlobalKey<NavigatorState>());

    //Provider初期化用
    // ref.read(weightProvider.notifier).initialize();
    // ref.read(customerProvider.notifier).initialize();
    // ref.read(appointmentManagementProvider.notifier).initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        controller: _controller,
        tabBar: CupertinoTabBar(
          height: 60,
          items: List.generate(
              _tabsList.length,
              (index) => BottomNavigationBarItem(
                  icon: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: _tabsList[index].icon),
                  label: _tabsList[index].label)),
          onTap: (index) async {
            if (exSelectedIndex == index) {
              _globalKeyList[index]
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            }
            _controller.index = index;
            setState(() {
              exSelectedIndex = index;
            });
          },
          currentIndex: _controller.index,
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            navigatorKey: _globalKeyList[index],
            builder: (context) {
              return _tabsList[index].widget;
            },
          );
        });
  }
}
