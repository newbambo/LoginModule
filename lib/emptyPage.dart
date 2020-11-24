

import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageRouteBuilder();

    return Scaffold(
      appBar: AppBar(title: Text('newPage'),),
      body: Container(
        child: Center(
          child: Text('空界面'),
        ),
      ),
    );
  }
}
