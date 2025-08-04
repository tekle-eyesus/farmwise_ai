import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DiseaseConfidenceChart extends StatelessWidget {
  final List<Map<String, dynamic>> results;

  const DiseaseConfidenceChart({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.0, bottom: 0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 9),
            decoration: BoxDecoration(
              color: const Color.fromARGB(22, 0, 0, 0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Confidence Levels by Detected Disease',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 8, 60, 55),
              ),
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 1.4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _getMaxY(results),
                gridData: FlGridData(
                  show: true,
                ),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final label = results[group.x.toInt()]['label'];
                      final confidence = (results[group.x.toInt()]
                              ['confidence'])
                          .toStringAsFixed(1);
                      return BarTooltipItem(
                        '$label\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: '$confidence%',
                            style: const TextStyle(
                              color: Colors.greenAccent,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: _getBottomTitle,
                      reservedSize: 42,
                    ),
                  ),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                barGroups: _generateBarGroups(results),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _generateBarGroups(List<Map<String, dynamic>> data) {
    return List.generate(data.length, (index) {
      final confidence = (data[index]['confidence'] as double);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: confidence,
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 8, 60, 55),
                Colors.lightGreenAccent
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(3),
            width: 26,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 100,
              color: Colors.grey[200],
            ),
          ),
        ],
      );
    });
  }

  double _getMaxY(List<Map<String, dynamic>> data) {
    final topConfidence = data
        .map((e) => e['confidence'] as double)
        .reduce((a, b) => a > b ? a : b);
    return (topConfidence * 100)
        .ceilToDouble()
        .clamp(50, 100); // At least 50, max 100
  }

  Widget _getBottomTitle(double value, TitleMeta meta) {
    final style = const TextStyle(fontSize: 10, fontWeight: FontWeight.w500);
    final index = value.toInt();
    if (index >= results.length) return const SizedBox.shrink();
    final label = results[index]['label'];
    return SideTitleWidget(
      space: 6,
      meta: meta,
      child: Transform.rotate(
        angle: results.length > 4
            ? -0.5
            : 0.0, // to rotate title for more that 4 classes.
        child: Text(
          label,
          style: style,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
