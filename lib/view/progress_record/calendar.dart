import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressCalendar extends ConsumerStatefulWidget {
  const ProgressCalendar({Key? key}) : super(key: key);

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
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: Colors.grey,
                            size: _iconSize,
                          ),
                          Text(
                            '122問',
                            style: Theme.of(context).textTheme.caption,
                          )
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
            )
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

    Widget dayWidget(String day) {
      return SizedBox(
          height: 50,
          width: 30,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              day,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ));
    }

    for (int day = 1; day <= lastDate.day; day++) {
      int weekDay = DateTime(date.year, date.month, day).weekday;
      weekWidget.add(dayWidget(day.toString()));

      if (weekDay == DateTime.saturday || day == lastDate.day) {
        if (day == lastDate.day) {
          //最終日なら右詰で７つ揃える
          while (weekWidget.length < 7) {
            weekWidget.add(dayWidget(""));
          }
        } else {
          //それ以外なら左詰で７つ揃える
          while (weekWidget.length < 7) {
            weekWidget.insert(0, dayWidget(""));
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
