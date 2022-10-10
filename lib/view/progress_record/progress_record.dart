import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/view/common_appbar.dart';
import 'multiplication/multiplication_progress.dart';

class ProgressRecord extends StatefulWidget {
  const ProgressRecord({Key? key}) : super(key: key);

  @override
  State<ProgressRecord> createState() => ProgressRecordState();
}

class ProgressRecordState extends State<ProgressRecord> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static const _tab = <Tab>[
    Tab(text: 'かけ算'),
    Tab(text: '円周率'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tab.length,
      child: Scaffold(
        appBar: const HomeAppBar(
          title: Text('記録'),
          bottom: TabBar(
            tabs: _tab,
            unselectedLabelColor: Color.fromRGBO(158, 158, 158, 1),
            labelColor: Colors.black,
          ),
        ),
        body: TabBarView(children: <Widget>[
          const MultiplicationProgress(),
          Container(),
        ]),
      ),
    );
  }
}
