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
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.hasClients) {
        controller.jumpTo(controller.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bestRecordsState = ref.watch(piBestRecordsListProvider);
    final bool isListEmpty = bestRecordsState.isEmpty;

    ///最新の最高記録を取得する
    final int lastRecord = isListEmpty ? 0 : bestRecordsState.last.bestRecord!;
    final DateTime? lastDate =
        isListEmpty ? null : DateTime.parse(bestRecordsState.last.date!);
    final DateFormat format = DateFormat('yyyy年MM月dd日');
    final String lastDateString =
        lastDate == null ? '' : format.format(lastDate);

    ///グラフの最小値と最大値を決定する。X軸はデフォルトで範囲ギリギリに描画するので左右に一つずつ余分にデータを取る
    ///Y軸は存在する範囲±１０をキャンバス範囲とする
    final int firstRecord =
        isListEmpty ? 0 : bestRecordsState.first.bestRecord!;
    final double minX = isListEmpty ? 0 : -1;
    final double minY = (firstRecord / 10 - 1).floorToDouble() > 0
        ? (firstRecord / 10 - 1).floorToDouble() * 10
        : 0;
    final double maxX = isListEmpty ? 10 : bestRecordsState.length.toDouble();
    final double maxY = (lastRecord / 10 + 1).floorToDouble() * 10;

    //最高記録リストの長さによってスクロール可能な範囲を決定する
    ///chart width = [bestRecordsState.length]+余白の両端二つ分に
    final double maxWidth = (bestRecordsState.length + 2) * 50 + 55;
    final double minWidth = MediaQuery.of(context).size.width - 55;
    final double lineWidth = minWidth > maxWidth ? minWidth : maxWidth;

    ///グラフ左にタイトルを描画する
    AxisTitles leftTitles({bool showTitles = true}) {
      return AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 40,
          showTitles: showTitles,
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

    ///グラフ下にタイトルを描画する
    AxisTitles bottomTitles() {
      ///前回の記録と年が違っていれば年から表記する
      String title(int value) {
        final DateTime date =
            DateTime.parse(bestRecordsState[value.toInt()].date!);
        DateTime? preDate;
        if (value != 0) {
          preDate = DateTime.parse(bestRecordsState[value.toInt() - 1].date!);
        }

        final DateFormat dateFormat = date.year == preDate?.year
            ? DateFormat('MM/dd')
            : DateFormat('yyyy/MM/dd');
        final String title = dateFormat.format(date);
        return title;
      }

      return AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 50,
          interval: 1,
          showTitles: !isListEmpty,
          getTitlesWidget: (value, meta) {
            //minX, maxXは余白分のため描画しない
            if (value == minX || value == maxX) return Container();
            return Transform.rotate(
              angle: -0.5,
              child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  margin: const EdgeInsets.only(right: 15),
                  child: Text(
                    title(value.toInt()),
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        ?.copyWith(fontSize: 12),
                  )),
            );
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
        SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          child: Container(
              height: 200,
              width: lineWidth,
              //軸のない上と右側にPaddingを設ける
              padding: const EdgeInsets.only(top: 15, right: 15),
              child: LineChart(LineChartData(
                minX: minX,
                minY: minY,
                maxX: maxX,
                maxY: maxY,
                lineBarsData: [
                  LineChartBarData(
                    barWidth: 2.0,
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
                  bottomTitles: bottomTitles(),
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
        ),
      ],
    );
  }
}
