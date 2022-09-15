import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/model/exercise_course.dart';
import 'package:flutter_pi_memorization/view/multiplication/tappable_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/multiplication_store.dart';
import '../../model/medal.dart';
import '../../model/multiplication_store.dart';

class ModeSelect extends StatelessWidget {
  final int id;

  const ModeSelect({Key? key, required this.id}) : super(key: key);

  //card shape
  static const double height = 80;
  static const EdgeInsets cardMargin =
      EdgeInsets.symmetric(vertical: 7, horizontal: 12);
  static final RoundedRectangleBorder border =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7));

  static const EdgeInsets _padding =
      EdgeInsets.symmetric(vertical: 7, horizontal: 12);

  @override
  Widget build(BuildContext context) {
    final ExcersiseCourse course = ExcersiseCourse.find(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: Column(children: [
        Padding(
          padding: _padding,
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
          onTap: () {},
          height: 60,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: _padding,
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
          padding: _padding,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'モード選択',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ),
        TappableCard(
            onTap: () {},
            height: height,
            margin: cardMargin,
            border: border,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer(builder: (context, ref, _) {
                final multiplicationState =
                    ref.watch(multiplicationProvider.notifier);
                return Column(
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
                          '挑戦回数${multiplicationState.find(id).practiceNum}回',
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
                );
              }),
            )),
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
                  TappableCard(
                      onTap: () {},
                      height: height,
                      border: border.copyWith(
                        side: const BorderSide(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Consumer(builder: (context, ref, _) {
                          final multiplicationState =
                              ref.watch(multiplicationProvider.notifier);
                          final Multiplication multiplication =
                              multiplicationState.find(id);

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: height,
                                    width: height,
                                    child: multiplication.beginnerDone
                                        ? Medal.beginner.icon
                                        : Medal.none.icon,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '初心者コース',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '挑戦回数${multiplicationState.find(id).practiceNum}回',
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
                          );
                        }),
                      )),
                  TappableCard(
                      onTap: () {},
                      height: height,
                      border: border.copyWith(
                        side: const BorderSide(
                          width: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Consumer(builder: (context, ref, _) {
                          final multiplicationState =
                              ref.watch(multiplicationProvider.notifier);
                          final Multiplication multiplication =
                              multiplicationState.find(id);

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: height,
                                    width: height,
                                    child: multiplication.professionalDone
                                        ? Medal.professional.icon
                                        : Medal.none.icon,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '達人コース',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '挑戦回数${multiplicationState.find(id).practiceNum}回',
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
                          );
                        }),
                      ))
                ],
              ),
            )),
      ]),
    );
  }
}
