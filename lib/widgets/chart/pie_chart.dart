import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpensesChart extends StatefulWidget {
  const ExpensesChart({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  State<ExpensesChart> createState() {
    return _ExpensesChartState();
  }
}

class _ExpensesChartState extends State<ExpensesChart> {
  int touchedIndex = -1;

  List<Expense> get expenses => widget.expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
      ExpenseBucket.forCategory(expenses, Category.savings),
    ];
  }

  double get totalExpenses {
    double total = 0;
    for (final bucket in buckets) {
      total += bucket.totalExpenses;
    }
    return total;
  }

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
              touchCallback:
                  (FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
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
    // Calculate all values ONCE, outside the loop
    final categories = [
      Category.food,
      Category.leisure,
      Category.savings,
      Category.travel,
      Category.work,
    ];

    final categoryValues = categories.map((category) {
      return ExpenseBucket.forCategory(expenses, category).totalExpenses;
    }).toList();

    final total = totalExpenses;

    return List.generate(categories.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 50.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      final category = categories[i];
      final value = categoryValues[i];
      final percentage = total > 0 ? (value / total * 100) : 0;

      final categoryNames = ['Food', 'Leisure', 'Savings', 'Travel', 'Work'];
      final categoryColors = [
        const Color.fromARGB(255, 232, 114, 114),
        const Color.fromARGB(255, 255, 239, 121),
        const Color.fromARGB(255, 184, 255, 136),
        const Color.fromARGB(255, 111, 185, 253),
        const Color.fromARGB(255, 255, 130, 253),
      ];

      return PieChartSectionData(
        color: categoryColors[i],
        value: value,
        title: '${categoryNames[i]}:\n${percentage.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
          color: Colors.black,
          shadows: shadows,
        ),
        badgeWidget: _Badge(
          Icon(categoryIcons[category]),
          size: widgetSize,
          borderColor: Colors.black,
        ),
        badgePositionPercentageOffset: .98,
      );
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
            color: Colors.black.withValues(alpha: 0.5),
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
