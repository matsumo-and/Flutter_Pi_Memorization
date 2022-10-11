import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/controller/pi_memolization/pi_best_record.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PiChart extends ConsumerStatefulWidget {
  const PiChart({Key? key}) : super(key: key);

  @override
  ConsumerState<PiChart> createState() => PiChartState();
}

class PiChartState extends ConsumerState<PiChart> {
  static const gridColor = Color.fromRGBO(158, 158, 158, 1);
  static const chartColor = Color.fromRGBO(81, 133, 213, 1);
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
    final bestRecordsState = ref.watch(piBestRecordsListProvider);
    final bool isListEmpty = bestRecordsState.isEmpty;

    final int lastRecord = isListEmpty ? 0 : bestRecordsState.last.bestRecord!;
    final DateTime? lastDate =
        isListEmpty ? null : DateTime.parse(bestRecordsState.last.date!);
    final DateFormat format = DateFormat('yyyy年MM月dd日');
    final String lastDateString =
        lastDate == null ? '' : format.format(lastDate);

    ///グラフの最小値と最大値を決定する。X軸はデフォルトで範囲ギリギリに描画するので左右に一つずつ余分にデータを取る
    ///Y軸は存在する範囲±１０をキャンバス範囲とする
    final double minX = isListEmpty ? 0 : -1;
    final double minY = (lastRecord / 10 - 1).floorToDouble() > 0
        ? (lastRecord / 10 - 1).floorToDouble() * 10
        : 0;
    final double maxX = isListEmpty ? 10 : bestRecordsState.length.toDouble();
    final double maxY = (lastRecord / 10 + 1).floorToDouble() * 10;

    AxisTitles leftTitles({double? intervals}) {
      return AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 40,
          interval: intervals,
          showTitles: true,
          getTitlesWidget: (value, meta) => Container(
              alignment: Alignment.centerRight,
              height: 30,
              width: 30,
              margin: const EdgeInsets.only(right: 15),
              child: Text(
                value.toInt().toString(),
                style:
                    Theme.of(context).textTheme.caption?.copyWith(fontSize: 12),
              )),
        ),
      );
    }

    AxisTitles bottomTitles({double? intervals}) {
      String title(double value) {
        final DateTime date =
            DateTime.parse(bestRecordsState[value.toInt()].date!);
        final DateTime? preDate = value == 0
            ? null
            : DateTime.parse(bestRecordsState[value.toInt() - 1].date!);
        final DateFormat dateFormat = date.year == preDate?.year
            ? DateFormat('MM/dd')
            : DateFormat('yyyy/MM/dd');
        final String title = dateFormat.format(date);
        return title;
      }

      return AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 40,
          interval: intervals,
          showTitles: !isListEmpty,
          getTitlesWidget: (value, meta) {
            //minX, maxXは余白分のため描画しない
            if (value == minX || value == maxX) return Container();
            return Container(
                alignment: Alignment.centerRight,
                height: 30,
                margin: const EdgeInsets.only(right: 15),
                child: Text(
                  title(value),
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontSize: 12),
                ));
          },
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text('最高記録', style: Theme.of(context).textTheme.caption),
        Text('$lastRecord 桁', style: Theme.of(context).textTheme.headline1),
        Text(lastDateString, style: Theme.of(context).textTheme.caption),

        //折れ線グラフ
        Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            //軸のない上と右側にPaddingを設ける
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: LineChart(LineChartData(
              minX: minX,
              minY: minY,
              maxX: maxX,
              maxY: maxY,
              lineBarsData: [
                LineChartBarData(
                  barWidth: 3.0,
                  color: chartColor,
                  spots: List.generate(
                      bestRecordsState.length,
                      (index) => FlSpot(index.toDouble(),
                          bestRecordsState[index].bestRecord!.toDouble())),
                  dotData: FlDotData(
                    getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                      color: Colors.white,
                      strokeColor: chartColor,
                      strokeWidth: 1,
                    ),
                  ),
                )
              ],
              titlesData: FlTitlesData(
                topTitles: AxisTitles(),
                bottomTitles: bottomTitles(intervals: 20),
                rightTitles: AxisTitles(),
                leftTitles: leftTitles(),
              ),
              gridData: FlGridData(
                drawHorizontalLine: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (_) => FlLine(
                  color: gridColor,
                  strokeWidth: 0.5,
                ),
              ),
              borderData: FlBorderData(
                  border: const Border.symmetric(
                      horizontal: BorderSide(color: gridColor, width: 0.5))),
            ))),
      ],
    );
  }
}
