import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/multiplication_store.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pi_store.dart';
import 'package:flutter_pi_memorization/model/tab.dart';
import 'package:flutter_pi_memorization/view/multiplication/multiplication_home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/multiplication_record.dart';
import 'pi_memorization/pi_memorization_home.dart';
import 'progress_record/progress_record.dart';

class BottomTabBar extends ConsumerStatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends ConsumerState<BottomTabBar> {
  late CupertinoTabController _controller;

  final List<Tabs> _tabsList = [
    const Tabs(
      widget: MultiplicationHome(),
      label: "かけ算",
      inactiveIcon: Icon(Icons.close),
      activeIcon: Icon(Icons.close),
    ),
    Tabs(
      widget: const PiMemorizationHome(),
      label: "円周率",
      inactiveIcon: Tabs.inactiveSvgIcon(fileName: "pi.svg"),
      activeIcon: Tabs.activeSvgIcon(fileName: "pi.svg"),
    ),
    Tabs(
      widget: const ProgressRecord(),
      label: "記録",
      inactiveIcon: Tabs.inactiveSvgIcon(fileName: "record.svg"),
      activeIcon: Tabs.activeSvgIcon(fileName: "record.svg"),
    ),
  ];

  List<GlobalKey<NavigatorState>> _globalKeyList = [];
  int exSelectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = CupertinoTabController();
    _globalKeyList =
        List.generate(_tabsList.length, (_) => GlobalKey<NavigatorState>());

    //Provider初期化用
    ref.read(multiplicationProvider.notifier).initialize();
    ref.read(multiplicationRecodeProvider.notifier).initialize();
    ref.read(piArchivementProvider.notifier).initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        resizeToAvoidBottomInset: false,
        controller: _controller,
        tabBar: CupertinoTabBar(
          height: 60,
          items: List.generate(
              _tabsList.length,
              (index) => BottomNavigationBarItem(
                  icon: Padding(
                      padding: const EdgeInsets.all(5),
                      child: _tabsList[index].inactiveIcon),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: _tabsList[index].activeIcon,
                  ),
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
              //TabBarで最後までスクロールが見えなくなるのを防ぐ
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                child: _tabsList[index].widget,
              );
            },
          );
        });
  }
}
