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

    final int lastRecord =
        bestRecordsState.isEmpty ? 0 : bestRecordsState.last.bestRecord!;
    final DateTime? lastDate = bestRecordsState.isEmpty
        ? null
        : DateTime.parse(bestRecordsState.last.date!);
    final DateFormat format = DateFormat('yyyy年MM月dd日');
    final String lastDateString =
        lastDate == null ? '' : format.format(lastDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text('最高記録', style: Theme.of(context).textTheme.caption),
        Text('$lastRecord 桁', style: Theme.of(context).textTheme.headline1),
        Text(lastDateString, style: Theme.of(context).textTheme.caption),
        SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: LineChart(LineChartData(
              minX: 0,
              minY: 0,
              maxX: 100,
              maxY: 100,
              lineBarsData: [
                LineChartBarData(
                    barWidth: 3.0, // 線の幅
                    color: const Color.fromRGBO(81, 133, 213, 1),
                    spots: List.generate(
                        bestRecordsState.length,
                        (index) => FlSpot(index.toDouble(),
                            bestRecordsState[index].bestRecord!.toDouble())))
              ],
              titlesData: FlTitlesData(
                topTitles: AxisTitles(),
                bottomTitles: AxisTitles(
                    axisNameWidget: Row(
                        children: List.generate(
                            bestRecordsState.length,
                            (index) =>
                                Text('${bestRecordsState[index].date}'))),
                    axisNameSize: 8),
                rightTitles: AxisTitles(),
              ),
              gridData: FlGridData(
                  drawHorizontalLine: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (_) => FlLine(
                        color: gridColor,
                        strokeWidth: 0.5,
                      )),
              borderData: FlBorderData(show: false),
            ))),
      ],
    );
  }
}
