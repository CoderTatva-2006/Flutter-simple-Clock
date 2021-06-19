import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:core';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:about/about.dart';

String inflate(int val) {
  if (val.toString().length == 1) {
    String ret = "0" + val.toString();
    return ret;
  }

  return val.toString();
}

class main_window extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _show_about() {
      showAboutPage(
        context: context,
        values: {
          'version': '1.0',
          'year': DateTime.now().year.toString(),
        },
        applicationLegalese: 'Copyright © Tatva Agarwal, {{ year }}',
        applicationDescription:
            const Text('A Simple Clock Application made using flutter'),
        children: <Widget>[
          LicensesPageListTile(
            icon: Icon(Icons.list),
          ),
        ],
        applicationIcon: const SizedBox(
          width: 100,
          height: 100,
          child: Image(
            image: AssetImage('Ontime.png'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Ontime"),
        actions: [
          IconButton(onPressed: _show_about, icon: Icon(Icons.info_outline)),
        ],
      ),
      body: digits(),
      floatingActionButton: floatbutton(),
    );
  }
}

class digits extends StatefulWidget {
  @override
  digitsState createState() => digitsState();
}

class digitsState extends State<digits> {
  String time_sec = inflate(DateTime.now().second).toString();
  String time_min = inflate(DateTime.now().minute).toString();
  String time_hour = inflate(DateTime.now().hour).toString();
  var now = DateTime.now();
  String delimitor = ":";

  @override
  Widget build(BuildContext context) {
    Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              time_sec = inflate(DateTime.now().second).toString();
              time_min = inflate(DateTime.now().minute).toString();
              time_hour = inflate(DateTime.now().hour).toString();
              now = DateTime.now();
            }));

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                time_hour,
                style: TextStyle(fontSize: 108),
              ),
              Text(
                delimitor + time_min,
                style: TextStyle(fontSize: 108),
              ),
              Text(
                delimitor + time_sec,
                style: TextStyle(fontSize: 108),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              Text(
                inflate(now.day).toString(),
                style: TextStyle(fontSize: 48),
              ),
              Text(
                " " + inflate(now.month).toString(),
                style: TextStyle(fontSize: 48),
              ),
              Text(
                " " + now.year.toString(),
                style: TextStyle(fontSize: 48),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}

class floatbutton extends StatefulWidget {
  @override
  _floatbuttonState createState() => _floatbuttonState();
}

class _floatbuttonState extends State<floatbutton> {
  bool mode = true; // true for dark , false for light.

  IconData icon = Icons.light_mode_rounded;

  void _update_mode() {
    setState(() {
      mode = !mode;
      if (!mode) {
        AdaptiveTheme.of(context).setLight();
        icon = Icons.dark_mode_outlined;
      } else {
        AdaptiveTheme.of(context).setDark();
        icon = Icons.light_mode_rounded;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _update_mode,
      child: Icon(icon),
    );
  }
}
