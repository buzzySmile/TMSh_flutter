import 'package:flutter/material.dart';

class ShortlistScreen extends StatefulWidget {
  ShortlistScreen();

  @override
  _ShortlistScreenState createState() => _ShortlistScreenState();
}

class _ShortlistScreenState extends State<ShortlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Center(
                child: Text('MOVIE TITLE'),
              ),
            ),
            ListTile(
              title: Center(
                child: Text('MOVIE TITLE'),
              ),
            ),
            ListTile(
              title: Center(
                child: Text('MOVIE TITLE'),
              ),
            )
          ],
        ));
  }
}
