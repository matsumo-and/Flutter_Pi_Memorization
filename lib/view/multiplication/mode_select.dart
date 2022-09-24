import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/model/multiplication/course.dart';
import 'package:flutter_pi_memorization/view/multiplication/calculation.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/multiplication_store.dart';
import '../../model/multiplication/medal.dart';
import '../../model/multiplication/multiplication_archivement.dart';

class ModeSelect extends ConsumerWidget {
  final int id;

  const ModeSelect({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //card shape
    const double height = 80;
    const EdgeInsets cardMargin =
        EdgeInsets.symmetric(vertical: 7, horizontal: 12);
    final RoundedRectangleBorder border =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(7));

    const EdgeInsets padding =
        EdgeInsets.symmetric(vertical: 7, horizontal: 12);
    //引数のIDを持つコースを探す
    final Course course = Course.find(id);

    //RiverpodのListの中で引数のIDを持つ掛け算成績を探す
    final multiplication = ref.watch(multiplicationProvider).firstWhere(
        (element) => element.id == id,
        orElse: (() => const Multiplication()));

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: Column(children: [
        Padding(
          padding: padding,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'チュートリアル',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),

        //チュートリアル
        TappableCard(
          border: border,
          margin: cardMargin,
          onTap: () {
            //TODO チュートリアル
          },
          height: 60,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: padding,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  '『${course.title}』の解き方のコツ',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        Padding(
          padding: padding,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'モード選択',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),

        //練習モード
        TappableCard(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) =>
                      CalculationPage(id: id, mode: CalculationMode.none)));
            },
            height: height,
            margin: cardMargin,
            border: border,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '練習モード',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        '挑戦回数${multiplication.practiceChallenges}回',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  Text(
                    '解答所要時間：無制限',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            )),

        //本番モード
        TappableCard(
            margin: cardMargin,
            border: border,
            onTap: null,
            ignoring: false,
            height: height * 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '本番モード',
                    style: Theme.of(context).textTheme.headline2,
                  ),

                  //初心者コース
                  TappableCard(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => CalculationPage(
                                id: id, mode: CalculationMode.beginner)));
                      },
                      height: height,
                      border: border.copyWith(
                        side: const BorderSide(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    height: height,
                                    width: height,
                                    child: multiplication.beginnerDone
                                        ? CalculationMode.beginner.medal
                                        : CalculationMode.none.medal,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '初心者コース',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    Text(
                                      '解答所要時間：60秒',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '挑戦回数${multiplication.beginnerChallenges}回',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                //Space調整のため
                                Text(
                                  '',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),

                  //達人コース
                  TappableCard(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => CalculationPage(
                                id: id, mode: CalculationMode.professional)));
                      },
                      height: height,
                      border: border.copyWith(
                        side: const BorderSide(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: height,
                                  width: height,
                                  child: multiplication.professionalDone
                                      ? CalculationMode.professional.medal
                                      : CalculationMode.none.medal,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '達人コース',
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                    Text(
                                      '解答所要時間：20秒',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '挑戦回数${multiplication.professionalChallenges}回',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                //Space調整のため
                                Text(
                                  '',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            )),
      ]),
    );
  }
}
