import 'package:flutter/material.dart';
import 'package:lab_6/authenticate/authenticate.dart';
import 'package:lab_6/home/home.dart';
import 'package:provider/provider.dart';
import 'package:lab_6/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
