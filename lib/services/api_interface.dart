import 'package:insta_app/services/api_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class ApiInterface {
  ApiHelper? apiHelper;

  ApiInterface(BuildContext context) {
    apiHelper = ApiHelper(context);
  }

  void doGetData({
    var header,
    required String url,
    VoidCallback? onRequestTimeOut,
    Function(dynamic error, Response response)? onUnhandleError,
    Function(Response response)? onFinish,
    Function()? onOffline,
  }) {
    apiHelper!.externalGet(
      route: url,
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void doLogin({
    var body,
    var header,
    VoidCallback? onRequestTimeOut,
    Function(dynamic error, Response response)? onUnhandleError,
    Function(Response response)? onFinish,
    Function()? onOffline,
  }) {
    apiHelper!.post(
      route: "login",
      body: body,
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void doCurrentUser({
    var header,
    VoidCallback? onRequestTimeOut,
    Function(dynamic error, Response response)? onUnhandleError,
    Function(Response response)? onFinish,
    Function()? onOffline,
  }) {
    apiHelper!.get(
      route: "user",
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void doRegisterAccount({
    var body,
    var header,
    VoidCallback? onRequestTimeOut,
    Function(dynamic error, Response response)? onUnhandleError,
    Function(Response response)? onFinish,
    Function()? onOffline,
  }) {
    apiHelper!.post(
      route: "register",
      body: body,
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }
}
