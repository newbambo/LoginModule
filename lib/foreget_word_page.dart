import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class  ForegetWordPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(color: Colors.red,
            width: double.infinity,
            height: 300,),
          Text('请联系管理员重置密码'),
          Text('下次登陆时请使用新密码进行登陆'),
          Text('联系电话: 021 -990909090'),
          Padding(padding : EdgeInsets.only(top: 20) ,
              child: loginButton((){
                Navigator.of(context).maybePop();
              })),
        ],
      ),
    );
  }

}

extension ForegetWordPageUI on ForegetWordPage {

  Widget loginButton( void Function() onTap){
    return  InkResponse(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular((25))
        ),
        child: Text( '前去登录',
            style: TextStyle(color: Colors.white, fontSize: 14)),
      ),);
  }
}

