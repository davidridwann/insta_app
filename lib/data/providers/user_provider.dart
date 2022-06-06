// ignore_for_file: prefer_collection_literals

import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:insta_app/data/providers/token_provider.dart';
import 'package:insta_app/services/api_interface.dart';
import 'package:insta_app/services/entities/login_response.dart';
import 'package:insta_app/services/entities/user_response.dart';
import 'package:insta_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User? user;
  SharedPreferences? prefs;
  ApiInterface? apiInterface;

  Future<User?> loadNetworkUser(BuildContext context,
      {bool reset = true, VoidCallback? onFinish}) async {
    Map<String, String> headers = Map();
    var token = stdin.readLineSync();
    if (context.read<TokenProvider>().token != null) {
      token = context.read<TokenProvider>().token;
      headers["Authorization"] = "Bearer " + token!;
    }

    apiInterface ??= ApiInterface(context);
    apiInterface!.doCurrentUser(
      header: headers,
      onFinish: (response) {
        UserResponse userReponse =
            UserResponse.fromJson(jsonDecode(response.body));

        if (response.statusCode == 200) {
          user = userReponse.data;
          saveLocalUser(user!);
          notifyListeners();
          if (reset) {
            onFinish!();
          }
        }
      },
    );

    return user;
  }

  void saveLocalUser(User user) async {
    this.user = user;

    if (prefs != null) {
      prefs!.setString(Constant.USER, jsonEncode(user.toJson()));
      notifyListeners();
    } else {
      await SharedPreferences.getInstance().then((currentPrefs) {
        prefs = currentPrefs;
        prefs!.setString(Constant.USER, jsonEncode(user.toJson()));
        notifyListeners();
      });
    }
  }

  void logoutUser() {
    prefs!.clear();
    notifyListeners();
  }

  Future<User?> loadLocalUser() async {
    if (prefs != null) {
      String? jsonUser = prefs!.getString(Constant.USER);
      if (jsonUser != null) {
        user = User.fromJson(jsonDecode(jsonUser));
        notifyListeners();

        return user;
      } else {
        return null;
      }
    } else {
      await SharedPreferences.getInstance().then((currentPrefs) {
        prefs = currentPrefs;
        String? jsonUser = prefs!.getString(Constant.USER);

        if (jsonUser != null) {
          user = User.fromJson(jsonDecode(jsonUser));
          notifyListeners();

          return user;
        } else {
          return null;
        }
      });
    }

    return user;
  }
}
