// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:insta_app/services/entities/post_detail_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:insta_app/data/providers/token_provider.dart';
import 'package:insta_app/services/api_interface.dart';
import 'package:insta_app/services/entities/post_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostProvider with ChangeNotifier {
  List<Post> posts = [];
  ApiInterface? apiInterface;
  bool loading = true;
  bool loadingHistory = true;
  bool loadingDetail = true;
  int page = 1;
  int pageHistory = 1;
  int maxPage = 9999;
  int maxPageHistory = 9999;
  PostDetailResponse? postDetail;
  RefreshController postRefreshController = RefreshController();

  void getPosts(BuildContext context, {bool resetPage = false}) {
    if (resetPage) {
      page = 1;
    }
    if (!postRefreshController.isRefresh) {
      // loading = true;
      // notifyListeners();
    }
    // ignore: prefer_conditional_assignment
    if (apiInterface == null) {
      apiInterface = ApiInterface(context);
    }

    Map<String, String> headers = HashMap();
    var token = stdin.readLineSync();
    if (context.read<TokenProvider>().token != null) {
      token = context.read<TokenProvider>().token;
      headers["Authorization"] = "Bearer " + token!;
    }
    apiInterface!.getPosts(
      page: page,
      header: headers,
      onUnhandleError: (e, response) {
        print(e);
      },
      onFinish: (response) {
        postRefreshController.refreshCompleted();
        postRefreshController.loadComplete();

        PostResponse userReponse =
            PostResponse.fromJson(jsonDecode(response.body));

        if (response.statusCode == 200) {
          maxPage = userReponse.data!.lastPage!;
          page++;
          if (resetPage) {
            posts.clear();
          }

          posts.addAll(userReponse.data!.data!);
          loading = false;
          notifyListeners();
        } else {
          posts.clear();
          loading = false;
          notifyListeners();
        }
      },
    );
  }

  Future<PostDetailResponse?> getDetailItem(
    BuildContext context, {
    int? id,
  }) async {
    Map<String, String> headers = HashMap();
    var token = stdin.readLineSync();
    token = context.read<TokenProvider>().token;
    headers['Authorization'] = "Bearer " + token!;
    apiInterface ??= ApiInterface(context);
    apiInterface!.doGetDetailPost(
      id: id,
      header: headers,
      onFinish: (response) {
        loadingDetail = false;
        PostDetailResponse postDetailResponse =
            PostDetailResponse.fromJson(jsonDecode(response.body));

        if (response.statusCode == 200) {
          notifyListeners();
          postDetail = postDetailResponse;
          return postDetail;
        }
      },
    );
    return postDetail;
  }
}
