library login_package;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'login_page.dart';
/// A Calculator.

class Calculator {

  int addOne(int value){
    return value + 1;
  }
}

///登陆结果回调
typedef loginResult  = void Function (bool res) ;

///登陆模块入口： 提供登陆功能和管理
class LoginModule {

  static login(BuildContext context , {loginResult callback}){

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context){
          return LoginPage(callback);
        },
          fullscreenDialog: true,
        ),);
  }
}