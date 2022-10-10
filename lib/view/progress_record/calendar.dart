import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/multiplication_record.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pi_challenges.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../model/record/total_challenges_record.dart';

enum CalendarType {
  multiplication,
  piMemorization,
}

class ProgressCalendar extends ConsumerStatefulWidget {
  final CalendarType calendarType;
  const ProgressCalendar({Key? key, required this.calendarType})
      : super(key: key);

  @override
  ConsumerState<ProgressCalendar> createState() => ProgressCalendarState();
}

class ProgressCalendarState extends ConsumerState<ProgressCalendar> {
  //calendar's first date
  static final DateTime firstDay = DateTime(2022, 1, 1);

  static const EdgeInsets _padding = EdgeInsets.all(12);
  static final ShapeBorder _cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7));
  static const double _iconSize = 16;

  final DateTime now = DateTime.now();

  //カレンダーに表示される年月を管理する
  late PageController controller;
  late final ValueNotifier<DateTime> viewDate;
  late int monthDiff;

  //掛け算または円周率の挑戦回数を管理
  late List<TotalChallengesRecord> recordList = [];

  @override
  void initState() {
    super.initState();
    viewDate = ValueNotifier(now);
    monthDiff = (now.year - firstDay.year) * 12 + now.month - firstDay.month;
    controller = PageController(initialPage: monthDiff);

    //calendarのコントローラーの値で表示年月を変更する
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(() {
        final int monthDiff = controller.page!.floor();
        viewDate.value =
            DateTime(firstDay.year, firstDay.month + monthDiff, firstDay.day);
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Typeによって掛け算または円周率の実績を切り替える
    recordList = widget.calendarType == CalendarType.multiplication
        ? ref.watch(multiplicationRecodeProvider)
        : ref.watch(piChallengesRecordProvider);
    return Card(
      elevation: 0,
      margin: _padding,
      shape: _cardShape,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //title
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '日別状況',
                  style: Theme.of(context).textTheme.headline1,
                )),

            //下線
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 0.5, color: Color.fromRGBO(33, 33, 33, 0.2))),
              ),
            ),

            //月選択
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.previousPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear);
                    },
                    icon: const Icon(Icons.arrow_back_ios, size: _iconSize),
                    splashRadius: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //現在の表示されているカレンダーの年月をListenする
                      ValueListenableBuilder<DateTime>(
                          valueListenable: viewDate,
                          builder: (context, value, _) {
                            return Text(
                              '${value.year}年${value.month}月',
                              style: Theme.of(context).textTheme.headline2,
                            );
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //Iconとテキストがどうしても一列に揃わない。日本語フォントのBaselineの高さとか関係してそう
                            padding: const EdgeInsets.only(bottom: 8),
                            height: 30,
                            width: 30,
                            child: const Icon(
                              Icons.check_circle_outline,
                              color: Colors.grey,
                              size: _iconSize,
                            ),
                          ),
                          //現在の表示されているカレンダーの年月をListenする
                          ValueListenableBuilder<DateTime>(
                              valueListenable: viewDate,
                              builder: (context, value, _) {
                                ///各月の総挑戦回数　＝　[yyyyMM]を含むList中の全ての挑戦回数の足し合わせ
                                final DateFormat format = DateFormat('yyyyMM');
                                final List<TotalChallengesRecord>
                                    totalChallengesListByMonth = recordList
                                        .where((record) => record.date!
                                            .contains(format.format(value)))
                                        .toList();
                                final int totalChallenges =
                                    totalChallengesListByMonth.fold(
                                        0,
                                        (preValue, record) =>
                                            preValue + record.totalChallenges);

                                return SizedBox(
                                  height: 30,
                                  child: Text(
                                    '$totalChallenges 回',
                                    style: Theme.of(context).textTheme.caption,
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear);
                    },
                    icon: const Icon(Icons.arrow_forward_ios, size: _iconSize),
                    splashRadius: 20,
                  ),
                ],
              ),
            ),

            //WeekDayRow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const ['日', '月', '火', '水', '木', '金', '土']
                  .map((weekday) => Text(
                        weekday,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ))
                  .toList(),
            ),

            //calendar
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: PageView(
                  controller: controller,
                  //最初の年月から現在までのカレンダーを作成する
                  children: List.generate(
                      monthDiff + 1,
                      (month) => calendarBase(
                          context: context,
                          date: DateTime(
                              firstDay.year, firstDay.month + month, 1)))),
            ),

            //下線
            Container(
              height: 15,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 0.5, color: Color.fromRGBO(33, 33, 33, 0.2))),
              ),
            ),

            //現在の表示されているカレンダーの年月をListenする
            ValueListenableBuilder<DateTime>(
                valueListenable: viewDate,
                builder: (context, value, _) {
                  ///[yyyyMM]をに合致する月別のリストを取得
                  final DateFormat format = DateFormat('yyyyMM');
                  final List<TotalChallengesRecord> totalChallengesListByMonth =
                      recordList
                          .where((record) =>
                              record.date!.contains(format.format(value)))
                          .toList();

                  return Column(
                    children: totalChallengesListByMonth.map(
                      (record) {
                        //表示用の日付フォーマットに変換
                        final DateTime date = DateTime.parse(record.date!);
                        final DateFormat recordFormat = DateFormat('MM月dd日');
                        final String recordDate = recordFormat.format(date);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(
                                  top: 9, bottom: 3, left: 6),
                              child: Text(recordDate),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(
                                  top: 3, bottom: 9, left: 6),
                              child: Text(
                                '${record.totalChallenges} 回',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList(),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget calendarBase({required BuildContext context, required DateTime date}) {
    //月末の日にちを取得
    final DateTime lastDate = DateTime(date.year, date.month + 1, 0);

    final List<List<Widget>> monthWidget = [[]];
    List<Widget> weekWidget = [];

    //今日の日付に薄いグレーをかける
    Color showToday(String day) {
      final int? parseDay = int.tryParse(day);

      if (parseDay == null) return Colors.transparent;

      final DateTime currentDate = DateTime(date.year, date.month, parseDay);
      final DateTime today = DateTime(now.year, now.month, now.day);

      return currentDate == today
          ? const Color.fromRGBO(200, 200, 200, 0.3)
          : Colors.transparent;
    }

    ///recordがNullや挑戦回数がない場合[challenges = 0]となる
    Widget dayWidget({required String day, required int challenges}) {
      const double maxWidth = 40;

      ///dayWidgetの最大幅 == [maxWidth]を円の最大直径、最小の直径を[20]とする
      ///挑戦回数が[1]の時最小,[25]の時最大となるように線形に直径を求める
      int maxRadius = challenges > 25 ? 25 : challenges;
      const int minRadius = 20;
      final double radius = minRadius + (maxWidth - minRadius) * maxRadius / 25;

      ///radiusが最大の時[Opacity = 1],最小の時[Opacity = 0.6]とする
      ///挑戦回数によって線形にOpacityを求める
      final Color circlueColor =
          Color.fromRGBO(103, 149, 224, 0.6 + 0.4 * maxRadius / 25);

      return challenges == 0
          ? Container(
              color: showToday(day),
              height: maxWidth,
              width: maxWidth,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  day,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ))
          : Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  color: showToday(day),
                  height: maxWidth,
                  width: maxWidth,
                ),
                Container(
                  height: radius,
                  width: radius,
                  decoration: BoxDecoration(
                      color: circlueColor,
                      borderRadius: BorderRadius.circular(24)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      day,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
    }

    for (int day = 1; day <= lastDate.day; day++) {
      //曜日を確認する
      final DateTime currentDate = DateTime(date.year, date.month, day);
      final int weekDay = currentDate.weekday;

      //実績にその日の記録が存在するか確認
      //なければDateがNullになる
      final DateFormat format = DateFormat('yyyyMMdd');
      final String formattedDate = format.format(currentDate);
      TotalChallengesRecord record = recordList.isNotEmpty
          ? recordList.firstWhere(
              (record) => record.date == formattedDate,
              orElse: () => const TotalChallengesRecord(date: null),
            )
          : const TotalChallengesRecord(date: null);

      //挑戦回数を取得
      final int challenges = record.date == null ? 0 : record.totalChallenges;

      //各日の日付と挑戦回数を渡す
      weekWidget.add(dayWidget(day: day.toString(), challenges: challenges));

      if (weekDay == DateTime.saturday || day == lastDate.day) {
        if (day == lastDate.day) {
          //最終日なら右詰で７つ揃える
          while (weekWidget.length < 7) {
            weekWidget.add(dayWidget(day: "", challenges: 0));
          }
        } else {
          //それ以外なら左詰で７つ揃える
          while (weekWidget.length < 7) {
            weekWidget.insert(0, dayWidget(day: "", challenges: 0));
          }
        }
        //土曜日区切りで二次元配列を生成
        monthWidget.add(weekWidget);
        weekWidget = [];
      }
    }

    return Column(
      //縦横に均等に配置する
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: monthWidget
          .map((weekList) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weekList.map((day) => day).toList()))
          .toList(),
    );
  }
}
