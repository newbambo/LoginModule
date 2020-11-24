

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier{

     String _verifyCode  = '1';
     String verifyImage = '1';

    Future<int> login(String username ,String password ,String verfyCode) async{
      await Future.delayed(Duration(seconds: 1));
      if (username == '111' && password == '111' && verfyCode == verifyImage) {
        return 0;
      }
      return 1 ;
    }

    refreshCode() async{
      await Future.delayed(Duration(seconds: 1));
      _verifyCode =  _verifyCode + '1';
      verifyImage  = verifyImage +  '1';
      print('你们 $verifyImage');
      notifyListeners();
    }

    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
    }


}