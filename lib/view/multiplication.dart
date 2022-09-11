import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/model/medal.dart';

class Multiplication extends StatelessWidget {
  const Multiplication({Key? key}) : super(key: key);

  static const EdgeInsets cardMargin =
      EdgeInsets.symmetric(vertical: 7, horizontal: 12);
  static final RoundedRectangleBorder border =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('かけ算'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: cardMargin,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '実戦コース',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Card(
              margin: cardMargin,
              color: Colors.white,
              shape: border,
              child: SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Row(children: [
                  Medal.none.icon,
                ]),
              )),
          const SizedBox(height: 30),
          Padding(
            padding: cardMargin,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '演習コース',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Card(
              margin: cardMargin,
              color: Colors.white,
              shape: border,
              child: SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Row(children: [
                  Medal.beginner.icon,
                ]),
              )),
          Card(
              margin: cardMargin,
              color: Colors.white,
              shape: border,
              child: SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Row(children: [
                  Medal.professional.icon,
                ]),
              )),
        ]),
      ),
    );
  }
}
