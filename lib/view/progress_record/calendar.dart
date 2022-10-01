import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class ProgressCalendar extends ConsumerStatefulWidget {
  const ProgressCalendar({Key? key}) : super(key: key);

  @override
  ConsumerState<ProgressCalendar> createState() => ProgressCalendarState();
}

class ProgressCalendarState extends ConsumerState<ProgressCalendar> {
  static const EdgeInsets _padding = EdgeInsets.all(12);
  static final ShapeBorder _cardShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(7));
  static const double _iconSize = 16;

  final DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios, size: _iconSize),
                    splashRadius: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${now.year}年${now.month}月',
                        style: Theme.of(context).textTheme.headline2,
                      ),
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
                    onPressed: () {},
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
            TableCalendar(
                headerVisible: false,
                daysOfWeekVisible: false,
                focusedDay: now,
                firstDay: now,
                lastDay: now),
          ],
        ),
      ),
    );
  }
}
