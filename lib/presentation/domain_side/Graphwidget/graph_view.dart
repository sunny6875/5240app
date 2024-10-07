// ignore_for_file: library_private_types_in_public_api

import 'package:fl_chart/fl_chart.dart';
import 'package:project_5240_frontend/presentation/domain_side/domin_home/controller/dominhome_controller.dart';
import 'package:project_5240_frontend/utils/extension.dart';

class GraphView extends StatefulWidget {
  const GraphView({super.key});

  @override
  _GraphViewState createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  String selectedPeriod = 'daily';
  List<String> periods = ["daily", "monthly", "weekly", "yearly"];
  Color graphColor = const Color(0XFF32B768);

  List<FlSpot> dailySpots = [
    const FlSpot(0, 500),
    const FlSpot(1, 800),
    const FlSpot(2, 600),
    const FlSpot(3, 1000),
    const FlSpot(4, 700),
    const FlSpot(6, 1200),
    const FlSpot(7, 800),
    const FlSpot(8, 1400),
    const FlSpot(9, 900),
    const FlSpot(10, 1600),
  ];

  List<FlSpot> monthlySpots = [
    const FlSpot(0, 500),
    const FlSpot(1, 800),
    const FlSpot(2, 1000),
    const FlSpot(3, 1200),
    const FlSpot(4, 1400),
    const FlSpot(6, 1600),
    const FlSpot(7, 1800),
    const FlSpot(8, 2000),
    const FlSpot(9, 2200),
    const FlSpot(10, 2600),
  ];
  List<FlSpot> weeklySpots = [
    const FlSpot(0, 500),
    const FlSpot(1, 800),
    const FlSpot(2, 1000),
    const FlSpot(3, 1200),
    const FlSpot(4, 1400),
    const FlSpot(5, 1600),
    const FlSpot(6, 1600),
    const FlSpot(7, 1600),
    const FlSpot(8, 1600),
    const FlSpot(9, 1600),
    const FlSpot(10, 1600),
  ];

  List<FlSpot> yearlySpots = [
    const FlSpot(0, 500),
    const FlSpot(1, 800),
    const FlSpot(2, 1000),
    const FlSpot(3, 1200),
    const FlSpot(4, 1400),
    const FlSpot(6, 1600),
    const FlSpot(7, 1800),
    const FlSpot(8, 2000),
    const FlSpot(9, 2200),
    const FlSpot(10, 2600),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DomainidController>(builder: (dominController) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Views',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton<String>(
                    value: selectedPeriod,
                    items: periods.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedPeriod = newValue!;
                      });
                    },
                    dropdownColor: Colors.white,
                    style: const TextStyle(color: Colors.grey),
                    underline: const SizedBox(),
                  ),
                ),
              ],
            ),
            Text(
              dominController.domainModel.value?.domain?.viewCount.toString() ??
                  "",
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 130,
              width: 360,
              child: LineChart(
                sampleData(),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<FlSpot> getSpots() {
    switch (selectedPeriod.toLowerCase()) {
      case 'monthly':
        return monthlySpots;
      case 'yearly':
        return yearlySpots;
      case 'weekly':
        return weeklySpots;
      case 'daily':
        return dailySpots;
      default:
        return dailySpots;
    }
  }

  LineChartData sampleData() {
    return LineChartData(
      baselineY: 1,
      gridData: const FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            interval: 1,
            maxIncluded: true,
            minIncluded: true,
            getTitlesWidget: (value, meta) {
              return getBottomTitle(value);
            },
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: false),
      // minX: 0,
      maxX: 10,
      // minY: 0,
      maxY: 2700,
      lineBarsData: [
        LineChartBarData(
          spots: getSpots(),
          isCurved: true,
          color: graphColor,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                graphColor.withOpacity(0.45),
                graphColor.withOpacity(0.35),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  Widget getBottomTitle(double value) {
    int index = value.round();
    if (index < 0 || index > 10) return const SizedBox.shrink();

    List<String> titles;
    switch (selectedPeriod.toLowerCase()) {
      case 'daily':
        titles = [
          '10AM',
          '11AM',
          '12PM',
          '1PM',
          '2PM',
          '3PM',
          '4PM',
          '5PM',
          '6PM',
          '7PM',
          '8PM'
        ];
        break;
      case 'monthly':
        titles = [
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun'
        ];
        break;
      case 'weekly':
        titles = [
          "Sun",
          "Mon",
          "Tue",
          "Wed",
          "Thu",
          "Fri",
          "Sat",
          "Wed",
          "Thu",
          "Fri",
          "Sat",
        ];
        break;
      case 'yearly':
        titles = [
          '2000',
          '2001',
          '2002',
          '2003',
          '2004',
          '2005',
          '2006',
          '2007',
          '2008',
          '2009',
          '2010'
        ];
        break;

      default:
        titles = [];
    }

    return Text(
      titles[index],
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: Colors.grey,
      ),
    );
  }
}
