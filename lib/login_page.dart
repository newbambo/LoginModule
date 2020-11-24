
import 'dart:math';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:login_package/ViewModel/login_provider.dart';
import 'package:login_package/foreget_word_page.dart';
import 'package:provider/provider.dart';

typedef successHandler  = void Function (bool res) ;

class LoginPage extends StatefulWidget {

  final successHandler;

  LoginPage(this.successHandler):super();

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginProvider _provider ;
  String  _username;
  String _password;
  String _verfycode;

  @override
  void initState() {
    // TODO: implement initState
    _provider = LoginProvider();
    _provider.refreshCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onEmptyArea,
        child: KeyboardAvoider(
          duration: Duration(seconds: 3),
          curve: Curves.linearToEaseOut,
          autoScroll: true,
          child: Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 0),
            child: Column(
              children: [
                // SpaceItem(200),
                Image.asset('packages/login_package/images/login_placehloder.png',height: 150,),
                LoginInputFiled('请输入账户', false, onUsernameChanged),
                SpaceItem(20),
                LoginInputFiled('请输入密码' , true ,onPasswordChanged),
                SpaceItem(20),
                ChangeNotifierProvider.value(value: _provider,
                    child:Builder(
                        builder: (context){
                          return verifyCodeItem(onRefreshCode,onVerfyCodeChanged,context);
                        }
                    ))
                ,
                SpaceItem(20),
                loginButton(onLogin),//登陆
                SpaceItem(20),
                Stack(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: InkResponse(onTap: onForgetPassWord, child: Text('忘记密码'))),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text('v 1.2.6')),
                  ],
                ),
              ],
            ),),
        ),
      ),
    );
  }
}

extension  LoginPageStateUI on _LoginPageState{

  Widget SpaceItem(double height){
    return  Divider(height: height,color: Colors.transparent,);
  }

  Widget LoginInputFiled(String placeholder,bool showSecure, void Function(String) changed){
    GlobalKey  fildKey = GlobalKey();
    return  TextField(
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: TextStyle(color: Colors.grey),
        // icon: Icon(Icons.phone),
        hoverColor: Colors.blue,
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ) ,
      cursorColor: Colors.blue,
      keyboardType:TextInputType.number ,
      obscureText: showSecure,
      onChanged:  changed,
    );
  }

  Widget verifyCodeItem(void Function() onRefresh ,void Function(String) changed ,BuildContext context){
    return   Row(children: [
      SizedBox(
        width: 150,
        child: TextField(
          decoration: InputDecoration(
            hintText: '请输入验证码',
            border:InputBorder.none,
            filled: true,
            fillColor: Colors.lightGreen,
          ),
          onChanged: changed,
        ),
      ),
      Container(height: 44,width: 100,color: Colors.yellow,
        // child: Text('ffafafa')),
        child: Text(Provider.of<LoginProvider>(context).verifyImage??'00'),),
      GestureDetector(
        onTap: onRefresh,
        child: SizedBox(
            width: 30,
            height: 30,
            child: Icon(Icons.refresh_rounded)),
      )],);
  }


  Widget loginButton( void Function() onTap){
    return  InkResponse(
      onTap: (){
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular((25))
        ),
        child: Text( '登录',
            style: TextStyle(color: Colors.white, fontSize: 14)),
      ),);
  }
}

extension LoginStateController on _LoginPageState{

    onEmptyArea(){
      FocusScope.of(context).requestFocus(FocusNode());
    }
     onLogin(){
       _provider.login(_username , _password,_verfycode)
           .then((value) {
         _provider.refreshCode();
         handleLoginResult(value);
       });
    }

    onForgetPassWord(){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return ForegetWordPage();
      },),);
    }

    onRefreshCode(){
        _provider.refreshCode();
    }
    
    onPasswordChanged(String newString){
      _password  = newString;
    }
    
    onUsernameChanged(String newString){
      _username  = newString;
    }
    
    onVerfyCodeChanged(String newString){
      _verfycode  = newString;
    }

    handleLoginResult( int res ){
      if (res == 0) {
        Navigator.maybePop(context);
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('登录失败 \n 账号或密码错误'),
              );
            });
      }
    }
    // onVerfiy(){
    //   LogUtil.e('点击了验证用户');
    // }
    // onRegister(){
    //   LogUtil.e('点击了注册新用户');
    // }

}