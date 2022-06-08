// ignore_for_file: avoid_print, must_be_immutable, prefer_final_fields, avoid_unnecessary_containers

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_app/components/buttons/primary_button.dart';
import 'package:insta_app/components/commons/default_appbar.dart';
import 'package:insta_app/components/dialogs/custom_alert_dialog.dart';
import 'package:insta_app/components/textareas/textarea.dart';
import 'package:insta_app/data/providers/post_provider.dart';
import 'package:insta_app/data/providers/token_provider.dart';
import 'package:insta_app/services/api_interface.dart';
import 'package:insta_app/services/entities/comment_response.dart';
import 'package:insta_app/services/entities/default_response.dart';
import 'package:insta_app/services/entities/post_detail_response.dart';
import 'package:insta_app/services/entities/post_response.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/tools.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailPostScreen extends StatefulWidget {
  final Post? item;
  const DetailPostScreen({Key? key, this.item}) : super(key: key);

  @override
  _DetailPostScreenState createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  ApiInterface? apiInterface;
  PostDetailResponse? postDetailResponse;
  CommentResponse? commentResponse;
  TextEditingController comment = TextEditingController();
  String? commentId;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      apiInterface = ApiInterface(context);
      Tools.showProgressDialog(context);
      getComments();
    });
  }

  void doComment() async {
    Map<String, String> headers = HashMap();
    Map<String, String> body = HashMap();

    var token = stdin.readLineSync();
    if (context.read<TokenProvider>().token != null) {
      token = context.read<TokenProvider>().token;
      headers["Authorization"] = "Bearer " + token!;
    }

    body['comment'] = comment.text;
    body['post_id'] = widget.item!.id.toString();
    if (commentId != null) {
      body['comment_id'] = commentId!;
    }

    apiInterface!.commentPost(
        body: body,
        header: headers,
        onUnhandleError: (e, response) {
          print(e);
        },
        onFinish: (response) async {
          Navigator.pop(context);

          DefaultResponse defaultResponse =
              DefaultResponse.fromJson(json.decode(response.body));

          if (response.statusCode == 200) {
            getComments();
          } else {
            Tools.showCustomDialog(
              context,
              dismissable: true,
              child: CustomAlertDialog(
                title: "Something went wrong!",
                message: defaultResponse.message!,
                buttonText: "OK",
                onConfirm: () {
                  Navigator.pop(context);
                },
              ),
            );
          }
        });
  }

  void getComments() {
    Map<String, String> headers = HashMap();
    var token = stdin.readLineSync();
    if (context.read<TokenProvider>().token != null) {
      token = context.read<TokenProvider>().token;
      headers["Authorization"] = "Bearer " + token!;
    }

    apiInterface!.getPostComment(
      id: widget.item!.id,
      header: headers,
      onFinish: (response) {
        setState(() {
          commentResponse = CommentResponse.fromJson(jsonDecode(response.body));

          Navigator.pop(context);
        });
      },
    );
  }

  void reply({String? cid, String? cname}) {
    setState(() {
      commentId = cid;
      comment.text = '@' + cname!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.white,
      appBar: DefaultAppBar(
        height: 66.h(context),
        title: "Comments",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w(context),
          vertical: 24.h(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.item!.created_by!,
                  style: Themes(context).blackBold12,
                ).addMarginRight(5.w(context)),
                Text(
                  widget.item!.caption!,
                  style: Themes(context).gray12,
                ),
              ],
            ).addMarginTop(4.h(context)),
            Text(
              widget.item == null
                  ? ""
                  : DateFormat("d MMM yyyy", "id")
                      .format(widget.item!.createdAt!),
              style: Themes(context).gray12,
            ),
            if (commentResponse != null)
              commentResponse!.data!.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w(context),
                        vertical: 12.h(context),
                      ),
                      shrinkWrap: true,
                      itemCount: commentResponse!.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    commentResponse!.data![index].created_by!,
                                    style: Themes(context).blackBold12,
                                  ).addMarginRight(5.w(context)),
                                  Text(
                                    commentResponse!.data![index].comment!,
                                    style: Themes(context).gray12,
                                  ).addMarginRight(10.w(context)),
                                  InkWell(
                                    onTap: () {
                                      reply(
                                          cid: commentResponse!.data![index].id!
                                              .toString(),
                                          cname: commentResponse!
                                              .data![index].created_by!);
                                    },
                                    child: Text(
                                      "Reply",
                                      style: Themes(context).primary12,
                                    ),
                                  ),
                                ],
                              ).addMarginTop(8.h(context)),
                              if (commentResponse!.data![index] != null)
                                commentResponse!.data![index].data!.isNotEmpty
                                    ? ListView.builder(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w(context),
                                          vertical: 12.h(context),
                                        ),
                                        shrinkWrap: true,
                                        itemCount: commentResponse!
                                            .data![index].data!.length,
                                        itemBuilder: (context, idx) {
                                          return Container(
                                            child: Row(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      commentResponse!
                                                          .data![index]
                                                          .data![idx]
                                                          .created_by!,
                                                      style: Themes(context)
                                                          .blackBold12,
                                                    ).addMarginRight(
                                                        5.w(context)),
                                                    Text(
                                                      commentResponse!
                                                          .data![index]
                                                          .data![idx]
                                                          .comment!,
                                                      style: Themes(context)
                                                          .gray12,
                                                    ).addMarginRight(
                                                        10.w(context)),
                                                  ],
                                                ).addMarginTop(8.h(context)),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : Container()
                            ],
                          ),
                        );
                      },
                    )
                  : Container(),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 2,
            color: Themes.stroke,
          ),
          Container(
            padding: EdgeInsets.all(16.w(context)),
            color: Themes.white,
            child: Column(
              children: [
                TextArea(
                  controller: comment,
                  hint: "Add a comment",
                ),
                PrimaryButton(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.w(context),
                    vertical: 5.w(context),
                  ),
                  onTap: comment.text.isEmpty
                      ? null
                      : () {
                          Tools.showProgressDialog(context);
                          doComment();
                        },
                  text: "POST",
                ).addMarginTop(5.h(context))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
