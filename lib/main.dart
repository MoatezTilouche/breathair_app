


import 'package:breathair_app/pages/login.dart';
import 'package:breathair_app/pages/welcome1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) =>  Welcome(),
    },
  ));
}