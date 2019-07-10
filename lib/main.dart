import 'package:flutter/material.dart';
import 'package:tmsh_flutter/injection.dart';
import 'package:tmsh_flutter/ui/search_screen.dart';

void main() {
  injectDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: SearchScreen(title: 'TMSh Demo'),
    );
  }
}
