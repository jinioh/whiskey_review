import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/WhiskeyTastingNoteProvier.dart';
import 'package:flutter_application_1/screens/review_write_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WhiskeyTastingNoteProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '위스키 테이스팅 앱',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: ReviewWriteScreen(),
    );
  }
}
