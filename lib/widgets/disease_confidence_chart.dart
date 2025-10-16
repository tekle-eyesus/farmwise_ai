import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DiseaseConfidenceChart extends StatelessWidget {
  final List<Map<String, dynamic>> results;

  const DiseaseConfidenceChart({super.key, required this.results});

  List<Map<String, dynamic>> get _topResults {
    // Sort by confidence descending and take top 5
    final sorted = List<Map<String, dynamic>>.from(results)
      ..sort((a, b) =>
          (b['confidence'] as double).compareTo(a['confidence'] as double));

    return sorted.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    final topResults = _topResults;
    final hasManyResults = results.length > 5;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade400,
                        Colors.blue.shade600,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Detection Confidence",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800,
                  ),
                ),
                const Spacer(),
                if (hasManyResults)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue.shade100,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list_rounded,
                          size: 12,
                          color: Colors.blue.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Top ${topResults.length} of ${results.length}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Chart Container
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade100,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200.withOpacity(0.8),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                if (hasManyResults)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.blue.shade100,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 16,
                          color: Colors.blue.shade600,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Showing top ${topResults.length} results by confidence. ${results.length - topResults.length} more detected.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade700,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Chart
                AspectRatio(
                  aspectRatio: 1.6,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: _getMaxY(topResults),
                      minY: 0,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: _getGridInterval(topResults),
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.shade200,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            final label = topResults[group.x.toInt()]['label'];
                            final confidence = (topResults[group.x.toInt()]
                                    ['confidence'])
                                .toStringAsFixed(1);
                            return BarTooltipItem(
                              '$label\n',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  text: '$confidence% confidence',
                                  style: const TextStyle(
                                    color: Colors.lightGreenAccent,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            interval: _getGridInterval(topResults),
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '${value.toInt()}%',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 45,
                            getTitlesWidget: (value, meta) =>
                                _getBottomTitle(value, meta, topResults),
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      barGroups: _generateBarGroups(topResults),
                    ),
                  ),
                ),

                // Legend for confidence levels
                if (topResults.length > 3)
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: topResults.asMap().entries.map((entry) {
                        final index = entry.key;
                        final result = entry.value;
                        final confidence =
                            (result['confidence']).toStringAsFixed(1);

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                gradient: _getBarGradient(result['confidence']),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${result['label']}: $confidence%',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
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
            gradient: _getBarGradient(data[index]['confidence']),
            borderRadius: BorderRadius.circular(4),
            width: 22,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 100,
              color: Colors.grey.shade100,
            ),
          ),
        ],
      );
    });
  }

  LinearGradient _getBarGradient(double confidence) {
    final percentage = confidence * 100;

    if (percentage >= 80) {
      return const LinearGradient(
        colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    } else if (percentage >= 60) {
      return const LinearGradient(
        colors: [Color(0xFFFF9800), Color(0xFFFFC107)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    } else {
      return const LinearGradient(
        colors: [Color(0xFFF44336), Color(0xFFFF5722)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    }
  }

  double _getMaxY(List<Map<String, dynamic>> data) {
    final topConfidence = data
        .map((e) => e['confidence'] as double)
        .reduce((a, b) => a > b ? a : b);
    final maxValue = (topConfidence).ceilToDouble();
    return maxValue.clamp(60, 100).toDouble();
  }

  double _getGridInterval(List<Map<String, dynamic>> data) {
    final maxY = _getMaxY(data);
    if (maxY <= 70) return 10;
    if (maxY <= 90) return 15;
    return 20;
  }

  Widget _getBottomTitle(
      double value, TitleMeta meta, List<Map<String, dynamic>> data) {
    final index = value.toInt();
    if (index >= data.length) return const SizedBox.shrink();

    final label = data[index]['label'];
    final confidence = (data[index]['confidence']).toStringAsFixed(1);

    return SideTitleWidget(
      meta: meta,
      space: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$confidence%',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: Colors.blue.shade700,
              ),
            ),
          ),
          // Disease label
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
