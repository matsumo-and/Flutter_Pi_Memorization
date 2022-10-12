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
    const gridColor = Color.fromRGBO(158, 158, 158, 1);
    const chartColor = Color.fromRGBO(81, 133, 213, 1);

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
    ///chart width = [bestRecordsState.length]+余白の両端二つ分に点同士の距離をかけ、軸の[reservedSize]とContainerの[padding]を足し合わせたもの
    final double maxWidth = (bestRecordsState.length + 2) * 50 + 55;
    final double minWidth = MediaQuery.of(context).size.width - 55;
    final double lineWidth = minWidth > maxWidth ? minWidth : maxWidth;

    //chartのプロットの丸のスタイル
    final FlDotData flDotData = FlDotData(
      getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
        color: Colors.white,
        strokeColor: chartColor,
        strokeWidth: 1,
      ),
    );

    ///グラフ左にタイトルを描画する
    AxisTitles leftTitles() {
      return AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 40,
          showTitles: true,
          getTitlesWidget: (value, meta) => Container(
              alignment: Alignment.centerRight,
              height: 30,
              width: 30,
              margin: const EdgeInsets.only(right: 15),
              child: Text(
                value.toInt().toString(),
                style: Theme.of(context).textTheme.caption,
              )),
        ),
      );
    }

    ///グラフ下にタイトルを描画する
    AxisTitles bottomTitles() {
      ///List indexを受け取って日付を返す
      String title(int value) {
        final DateTime date =
            DateTime.parse(bestRecordsState[value.toInt()].date!);
        DateTime? preDate;
        if (value != 0) {
          preDate = DateTime.parse(bestRecordsState[value.toInt() - 1].date!);
        }

        ///前回の記録と年が違っていれば年から表記する
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
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    title(value.toInt()),
                    style: Theme.of(context).textTheme.caption,
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

        //折れ線グラフを横方向にスクロールする
        SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          child: Container(
              height: 200,
              width: lineWidth,
              //軸のない上と右側にPaddingを設ける
              padding: const EdgeInsets.only(top: 15, right: 15),
              margin: const EdgeInsets.only(top: 15),

              //折れ線グラフ
              child: LineChart(LineChartData(
                minX: minX,
                minY: minY,
                maxX: maxX,
                maxY: maxY,

                //実データ
                lineBarsData: [
                  LineChartBarData(
                    barWidth: 2.0,
                    color: chartColor,
                    spots: List.generate(
                        bestRecordsState.length,
                        (index) => FlSpot(index.toDouble(),
                            bestRecordsState[index].bestRecord!.toDouble())),
                    dotData: flDotData,
                  )
                ],

                //タップ時のツールチップ
                lineTouchData: LineTouchData(
                    getTouchedSpotIndicator: (barData, spotIndexes) =>
                        List.generate(
                            spotIndexes.length,
                            (index) => TouchedSpotIndicatorData(
                                FlLine(color: chartColor, strokeWidth: 2),
                                flDotData)),
                    touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: gridColor.withOpacity(0.2),
                        getTooltipItems: (list) => List.generate(
                            list.length,
                            (index) => LineTooltipItem(
                                list[index].y.toInt().toString(),
                                const TextStyle())))),

                //上下左右の軸タイトル
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(),
                  bottomTitles: bottomTitles(),
                  rightTitles: AxisTitles(),
                  leftTitles: leftTitles(),
                ),

                //グラフ中のグリッド
                gridData: FlGridData(
                  drawHorizontalLine: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: gridColor,
                    strokeWidth: 0.5,
                  ),
                ),

                //グラフを囲う枠線
                borderData: FlBorderData(
                    border: const Border.symmetric(
                        horizontal: BorderSide(color: gridColor, width: 0.5))),
              ))),
        ),
      ],
    );
  }
}
