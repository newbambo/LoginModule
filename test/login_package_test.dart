import 'package:flutter_test/flutter_test.dart';

import 'package:login_package/login_package.dart';
import 'package:login_package/login_page.dart';
import 'package:flutter/material.dart';
void main() {
  testWidgets('loginpage test', (WidgetTester tester ) async{

    bool flag = false;
    await tester.pumpWidget(MaterialApp(
      home:LoginPage(null) ,
    ));

  });
  
  // test('adds one to input values', () {
  //   final calculator = Calculator();
  //   expect(calculator.addOne(2), 3);
  //   expect(calculator.addOne(-7), -6);
  //   expect(calculator.addOne(0), 1);
  //
  //
  //   expect(() => calculator.addOne(null), throwsNoSuchMethodError);
  // });
}
