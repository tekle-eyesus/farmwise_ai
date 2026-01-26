import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DiseaseConfidenceChart extends StatelessWidget {
  final List<Map<String, dynamic>> results;

  const DiseaseConfidenceChart({super.key, required this.results});

  // Helper to normalize data: Sorts, Takes Top 5, and Converts 0.76 -> 76.0
  List<Map<String, dynamic>> get _processedResults {
    // 1. Sort by confidence descending
    final sorted = List<Map<String, dynamic>>.from(results)
      ..sort(
          (a, b) => (b['confidence'] as num).compareTo(a['confidence'] as num));

    // 2. Take Top 5 and Normalize to 0-100 scale
    return sorted.take(5).map((e) {
      double rawConf = (e['confidence'] as num).toDouble();
      // Check if data is already 0-100 or 0-1.
      // API usually gives 0.76, so we multiply by 100.
      double pct = rawConf > 1.0 ? rawConf : rawConf * 100;

      return {
        'label': e['label'],
        'confidence': pct, // Now strictly 0.0 to 100.0
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final topResults = _processedResults; // Use the processed list
    final hasManyResults = results.length > 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Header Section ---
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade600],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Detection Confidence",
                style: TextStyle(
                  fontSize: 18, // Slightly reduced for better fit
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
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  child: Text(
                    'Top ${topResults.length}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // --- Chart Container ---
        Container(
          padding: const EdgeInsets.fromLTRB(
              16, 24, 16, 16), // Added top padding for labels
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade100, width: 1),
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
              // Chart
              AspectRatio(
                aspectRatio: 1.5,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    // FIX: MaxY must be 100 to match the background bars
                    maxY: 100,
                    minY: 0,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval:
                          20, // Clean intervals: 0, 20, 40... 100
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey.shade100,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final item = topResults[group.x.toInt()];
                          return BarTooltipItem(
                            '${item['label']}\n',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${(item['confidence'] as double).toStringAsFixed(1)}%',
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
                      // Left Axis (Percentages)
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 20,
                          getTitlesWidget: (value, meta) {
                            if (value > 100) return const SizedBox();
                            return Text(
                              '${value.toInt()}', // Simplified: "100" instead of "100%"
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                      ),
                      // Bottom Axis (Bars)
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50, // More space for labels
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
                    borderData:
                        FlBorderData(show: false), // Clean look without border
                    barGroups: _generateBarGroups(topResults),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _generateBarGroups(List<Map<String, dynamic>> data) {
    return List.generate(data.length, (index) {
      final confidence = data[index]['confidence'] as double;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: confidence, // This is now 0-100
            gradient: _getBarGradient(confidence),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            width: 18,
            // Background Bar
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 100, // Matches the Chart maxY
              color: Colors.grey.shade100,
            ),
          ),
        ],
      );
    });
  }

  LinearGradient _getBarGradient(double percentage) {
    // Input is now 0-100
    if (percentage >= 75) {
      return const LinearGradient(
        colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    } else if (percentage >= 40) {
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

  Widget _getBottomTitle(
      double value, TitleMeta meta, List<Map<String, dynamic>> data) {
    final index = value.toInt();
    if (index >= data.length) return const SizedBox.shrink();

    final label = data[index]['label'];
    final confidence = (data[index]['confidence'] as double).toStringAsFixed(1);

    return SideTitleWidget(
      meta: meta,
      space: 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Percentage Bubble
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$confidence%',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.blue.shade700,
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Label text
          SizedBox(
            width: 65,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
                height: 1.1,
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
