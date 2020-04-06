import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserInfo with ChangeNotifier{

  final String _endPoin = "";

  // User ID & Token -> LocalDb

  String userId;
  String userPw;
  String userToken;

  UserInfo({this.userId, this.userPw, this.userToken})
  : assert(userId != null),
    assert(userPw != null),
    assert(userToken != null);

}