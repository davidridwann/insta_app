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

  void getPosts({
    var header,
    int? page,
    VoidCallback? onRequestTimeOut,
    Function(dynamic error, Response response)? onUnhandleError,
    Function(Response response)? onFinish,
    Function()? onOffline,
  }) {
    apiHelper!.get(
      route: "post/get?page=$page",
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void doGetDetailPost({
    int? id,
    var header,
    VoidCallback? onRequestTimeOut,
    Function(dynamic error, Response response)? onUnhandleError,
    Function(Response response)? onFinish,
    Function()? onOffline,
  }) {
    apiHelper!.get(
      route: "post/show/$id",
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void doCreatePost({
    var body,
    var header,
    var files,
    VoidCallback? onRequestTimeOut,
    Function(dynamic error, StreamedResponse response)? onUnhandleError,
    Function(StreamedResponse response)? onFinish,
  }) {
    apiHelper!.multipartPost(
      route: "post/store",
      body: body,
      files: files,
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
    );
  }

  void doUpdatePost({
    int? id,
    var body,
    var header,
    var files,
    VoidCallback? onRequestTimeOut,
    Function(dynamic error, StreamedResponse response)? onUnhandleError,
    Function(StreamedResponse response)? onFinish,
  }) {
    apiHelper!.multipartPost(
      route: "post/update/$id",
      body: body,
      files: files,
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
    );
  }

  void likePost({
    int? id,
    var header,
    VoidCallback? onRequestTimeOut,
    Function(dynamic error, Response response)? onUnhandleError,
    Function(Response response)? onFinish,
    Function()? onOffline,
  }) {
    apiHelper!.post(
      route: "like/store/$id",
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void commentPost({
    var body,
    var header,
    VoidCallback? onRequestTimeOut,
    Function(dynamic error, Response response)? onUnhandleError,
    Function(Response response)? onFinish,
    Function()? onOffline,
  }) {
    apiHelper!.post(
      route: "comment/store",
      body: body,
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void getPostComment({
    int? id,
    var header,
    VoidCallback? onRequestTimeOut,
    Function(dynamic error, Response response)? onUnhandleError,
    Function(Response response)? onFinish,
    Function()? onOffline,
  }) {
    apiHelper!.get(
      route: "comment/get/$id",
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }

  void deletePost({
    int? id,
    var header,
    VoidCallback? onRequestTimeOut,
    Function(dynamic error, Response response)? onUnhandleError,
    Function(Response response)? onFinish,
    Function()? onOffline,
  }) {
    apiHelper!.delete(
      route: "post/destroy/$id",
      header: header,
      onFinish: onFinish,
      onRequestTimeOut: onRequestTimeOut,
      onUnhandleError: onUnhandleError,
      onOffline: onOffline,
    );
  }
}
