import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assembli/models/course_model.dart';

class attendanceAnalytics extends StatefulWidget {
  final Course course;

  const attendanceAnalytics({
    Key? key,
    required this.course,
  }) : super(key: key);
  @override
  State<attendanceAnalytics> createState() => _attendanceAnalyticsState();
}

class _attendanceAnalyticsState extends State<attendanceAnalytics> {
  final Stream<QuerySnapshot> _attendanceStream =
      FirebaseFirestore.instance.collection('Attendance').snapshots();
  late int present = 0;
  //edit Dylan Lowman
  late int absent = 0;

  List<ChartData> chartData = <ChartData>[
    ChartData('Present', 0, const Color.fromARGB(255, 179, 194, 168)),
    ChartData('Absent', 0, const Color.fromARGB(255, 4, 0, 0)),
  ];

  /// Method to update the chart data.
  List<ChartData> _getChartData(int present, int absent) {
    chartData.add(ChartData("Present", present.toDouble(),
        const Color.fromARGB(255, 179, 194, 168)));
    chartData.add(ChartData(
        "Absent", absent.toDouble(), const Color.fromARGB(255, 4, 0, 0)));

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 179, 194, 168),
          title: Text('Assembli'),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Container(
              height: 50,
              width: 250,
            ),
            SfCircularChart(
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic),
                iconHeight: 30,
                iconWidth: 30,
                padding: 30,
              ),
              title: ChartTitle(
                  text: 'Class Attendance',
                  alignment: ChartAlignment.center,
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 179, 194, 168),
                    fontWeight: FontWeight.w900,
                    fontSize: 35,
                  )),
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                    widget: Container(
                  child: Text(
                      present.toString() + "/" + (absent + present).toString()),
                ))
              ],
              series: <CircularSeries>[
                // Renders doughnut chart
                DoughnutSeries<ChartData, String>(
                    dataSource: chartData,
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    radius: '120%')
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _attendanceStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  debugPrint('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  debugPrint("Loading");
                }

                if (snapshot.hasData) {
                  present = 0;
                  absent = 0;
                  snapshot.data?.docs.forEach((doc) {
                    if (doc
                        .data()
                        .toString()
                        .contains(widget.course.crn.toString())) {
                      if (doc['coursePresence.${widget.course.crn}'] == true) {
                        present += 1;
                      } else {
                        absent += 1;
                      }
                    } else {
                      debugPrint(
                          "A User in the snapshot is not apart of the class");
                    }
                  });
                }
                return Container();
              },
            ),
            Container(height: 50, width: 250),
            FloatingActionButton(
              onPressed: () => setState(
                () {
                  chartData = <ChartData>[];
                  chartData = _getChartData(present, absent);
                },
              ),
              child: const Icon(Icons.refresh, color: Colors.white),
              backgroundColor: (const Color.fromARGB(255, 179, 194, 168)),
            ),
            Container(height: 150, width: 250),
          ]),
        ));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
