import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpensesChart extends StatefulWidget {
  const ExpensesChart({super.key});

  @override
  State<ExpensesChart> createState() {
    return _ExpensesChartState();
  }
}

class _ExpensesChartState extends State<ExpensesChart> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(
            255,
            196,
            196,
            196,
          ).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 250,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, PieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      PieTouchResponse == null ||
                      PieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      PieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: showingSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(categoryIcons.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 50.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return switch (i) {
        0 => PieChartSectionData(
          color: const Color.fromARGB(255, 232, 114, 114),
          value: 40,
          title: '40%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            shadows: shadows,
          ),
          badgeWidget: _Badge(
            Icon(categoryIcons[Category.food]),
            size: widgetSize,
            borderColor: Colors.black,
          ),
          badgePositionPercentageOffset: .98,
        ),
        1 => PieChartSectionData(
          color: const Color.fromARGB(255, 255, 239, 121),
          value: 30,
          title: '30%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            shadows: shadows,
          ),
          badgeWidget: _Badge(
            Icon(categoryIcons[Category.leisure]),
            size: widgetSize,
            borderColor: Colors.black,
          ),
          badgePositionPercentageOffset: .98,
        ),
        2 => PieChartSectionData(
          color: const Color.fromARGB(255, 184, 255, 136),
          value: 16,
          title: '16%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            shadows: shadows,
          ),
          badgeWidget: _Badge(
            Icon(categoryIcons[Category.savings]),
            size: widgetSize,
            borderColor: Colors.black,
          ),
          badgePositionPercentageOffset: .98,
        ),
        3 => PieChartSectionData(
          color: const Color.fromARGB(255, 111, 185, 253),
          value: 10,
          title: '10%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            shadows: shadows,
          ),
          badgeWidget: _Badge(
            Icon(categoryIcons[Category.travel]),
            size: widgetSize,
            borderColor: Colors.black,
          ),
          badgePositionPercentageOffset: .98,
        ),
        4 => PieChartSectionData(
          color: const Color.fromARGB(255, 255, 130, 253),
          value: 5,
          title: '5%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            shadows: shadows,
          ),
          badgeWidget: _Badge(
            Icon(categoryIcons[Category.work]),
            size: widgetSize,
            borderColor: Colors.black,
          ),
          badgePositionPercentageOffset: .98,
        ),
        _ => throw StateError('Invalid'),
      };
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.usedIcon, {
    required this.size,
    required this.borderColor,
  });

  final Icon usedIcon;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: usedIcon,
    );
  }
}
