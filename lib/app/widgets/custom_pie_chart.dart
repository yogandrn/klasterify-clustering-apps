import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:klasterify/app/theme/colors.dart';
import 'package:klasterify/app/theme/size.dart';

class CustomPieChart extends StatefulWidget {
  const CustomPieChart({
    super.key,
    required this.cluster1,
    required this.cluster2,
    required this.cluster3,
  });
  final int cluster1, cluster2, cluster3;

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: maxHeight < 700 ? maxHeight / 2.5 : maxHeight / 3.4,
          width: maxWidth,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
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
              sectionsSpace: 0,
              centerSpaceRadius: maxHeight / 20,
              sections: showingSections(),
            ),
          ),
        ),
        // const Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     Indicator(
        //       color: AppColors.contentColorBlue,
        //       text: 'First',
        //       isSquare: true,
        //     ),
        //     SizedBox(
        //       height: 4,
        //     ),
        //     Indicator(
        //       color: AppColors.contentColorYellow,
        //       text: 'Second',
        //       isSquare: true,
        //     ),
        //     SizedBox(
        //       height: 4,
        //     ),
        //     Indicator(
        //       color: AppColors.contentColorPurple,
        //       text: 'Third',
        //       isSquare: true,
        //     ),
        //     SizedBox(
        //       height: 4,
        //     ),
        //     Indicator(
        //       color: AppColors.contentColorGreen,
        //       text: 'Fourth',
        //       isSquare: true,
        //     ),
        //     SizedBox(
        //       height: 18,
        //     ),
        //   ],
        // ),
        Row(
          children: [
            Wrap(
              children: [
                Container(
                  width: marginLarge,
                  height: marginLarge,
                  color: secondaryColor,
                ),
                Text('${widget.cluster2}'),
              ],
            ),
            Wrap(
              children: [
                Container(
                  width: marginLarge,
                  height: marginLarge,
                  color: secondaryColorLight,
                ),
                Text('${widget.cluster1}'),
              ],
            ),
            // Wrap(
            //   children: [
            //     Container(
            //       width: marginLarge,
            //       height: marginLarge,
            //       color: primaryColor,
            //     ),
            //     Text('${widget.cluster3}'),
            //   ],
            // ),
          ],
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? maxHeight / 45 : maxHeight / 54;
      final radius = isTouched ? 60.0 : 50.0;
      // const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: secondaryColor,
            value: widget.cluster2.toDouble(),
            title: '${widget.cluster2}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: whiteColor,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: secondaryColorLight,
            value: widget.cluster1.toDouble(),
            title: '${widget.cluster1}',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: blackColor,
            ),
          );
        // case 2:
        //   return PieChartSectionData(
        //     color: primaryColor,
        //     value: widget.cluster3.toDouble(),
        //     title: '${widget.cluster3}',
        //     radius: radius,
        //     titleStyle: TextStyle(
        //       fontSize: fontSize,
        //       fontWeight: FontWeight.bold,
        //       color: whiteColor,
        //       shadows: shadows,
        //     ),
        //   );
        default:
          throw Error();
      }
    });
  }
}
