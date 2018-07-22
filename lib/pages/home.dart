import 'package:flutter/material.dart';
import '../widgets/exchange.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exchange Flutter')
        ),
        body: Center(
          child: Exchange()
        ),
      ),
    );
  }
}