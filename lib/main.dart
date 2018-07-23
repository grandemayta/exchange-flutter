import 'package:flutter/material.dart';
import './pages/exchange.dart';
import './pages/credits.dart';

void main() => runApp(new MaterialApp(
  home: Exchange(),
  routes: <String, WidgetBuilder>{
    "/exchange": (BuildContext context) => Exchange(),
    "/credits": (BuildContext context) => Credits()
  }
));
