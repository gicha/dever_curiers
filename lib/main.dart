import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';


void main() {
  runApp(new MaterialApp(
    home: new AnimatedRadialChartExample(),
  ));
}

class AnimatedRadialChartExample extends StatefulWidget {
  @override
  _AnimatedRadialChartExampleState createState() =>
      new _AnimatedRadialChartExampleState();
}

class _AnimatedRadialChartExampleState
    extends State<AnimatedRadialChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
  new GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(400.0, 550.0);


  double value = 110.0;

  void _increment() {
    setState(() {
      value += 10;
      List<CircularStackEntry> data = _generateChartData(value);
      _chartKey.currentState.updateData(data);
    });
  }

  void _decrement() {
    setState(() {
      value -= 10;
      List<CircularStackEntry> data = _generateChartData(value);
      _chartKey.currentState.updateData(data);
    });
  }

  List<CircularStackEntry> _generateChartData(double value) {
    Color dialColor = Colors.black;
    if (value < 0) {
      dialColor = Colors.black;
    } else if (value < 10) {
      dialColor = Colors.black;
    }

    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            value,
            dialColor,
            rankKey: 'percentage',
          )
        ],
        rankKey: 'percentage',
      ),
    ];

    if (value > 20) {
      data.add(new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            value - 20,
            Colors.black,
            rankKey: 'percentage',
          ),
        ],
        rankKey: 'percentage2',
      ));
    }
    if (value > 40) {
      data.add(new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            value - 40,
            Colors.black,
            rankKey: 'percentage',
          ),
        ],
        rankKey: 'percentage2',
      ));
    }
    if (value > 60) {
      data.add(new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            value - 60,
            Colors.black,
            rankKey: 'percentage',
          ),
        ],
        rankKey: 'percentage2',
      ));
    }
    if (value > 80) {
      data.add(new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            value - 80,
            Colors.black,
            rankKey: 'percentage',
          ),
        ],
        rankKey: 'percentage2',
      ));
    }
    if (value > 100) {
      data.add(new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            value - 100,
            Colors.black,
            rankKey: 'percentage',
          ),
        ],
        rankKey: 'percentage2',
      ));
    }

    return data;
  }

  initState() {
    var location = new Location();
    location.onLocationChanged.listen((
        Map<String, double> currentLocation) async {
      print(currentLocation["latitude"]);
      print(currentLocation["longitude"]);
      print(currentLocation["accuracy"]);
      print(currentLocation["altitude"]);

      var httpClient = new HttpClient();
      var data = currentLocation["longitude"].toString() + "," +
          currentLocation["latitude"].toString();
      var uri = new Uri.http(
          'dever.itis.team', '/order/set_state/1/P/' + data);
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(UTF8.decoder).join();
      print(responseBody);
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:
        new Column(
        children: <Widget>[
          new Container(
            child: new AnimatedCircularChart(
              key: _chartKey,
              size: _chartSize,
              initialChartData: _generateChartData(value),
              chartType: CircularChartType.Radial,
              percentageValues: true,
            ),
          ),
          new Text(
            '$value%',
            style: Theme
                .of(context)
                .textTheme
                .title,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
            ],
          ),
        ],
      ),
    );
  }
}
