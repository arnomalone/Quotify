import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/connection.dart';
import 'package:quotes/constants.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _data;
  Map _snap;
  CountdownController _countdownController = CountdownController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Center(
          child: StreamBuilder(
            stream: _getQuote(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _snap = snapshot.data;
                _countdownController.restart();
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: kBoxColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.5),
                            child: Text(
                              _snap['content'],
                              style: GoogleFonts.lato(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: kTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Countdown(
                        controller: _countdownController,
                        seconds: 15,
                        build: (BuildContext context, double time) => Text(
                          'Next quote in: ' + time.toInt().toString(),
                          style: GoogleFonts.lato(
                              fontSize: 15.0, color: kCountdownColor),
                        ),
                        interval: Duration(milliseconds: 1000),
                        onFinished: () {},
                      )
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator(
                  backgroundColor: kBoxColor,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  _reset() {
    _getQuote();
  }

  _getQuote() async* {
    while (true) {
      await Future.delayed(kDuration);
      yield await NetworkHelper(kAPI).getData();
    }
  }
}
