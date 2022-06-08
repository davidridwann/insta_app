// ignore_for_file: avoid_print, must_be_immutable, prefer_final_fields

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:insta_app/components/buttons/primary_button.dart';
import 'package:insta_app/components/commons/default_appbar.dart';
import 'package:insta_app/components/dialogs/custom_alert_dialog.dart';
import 'package:insta_app/components/textareas/textarea.dart';
import 'package:insta_app/data/providers/post_provider.dart';
import 'package:insta_app/data/providers/token_provider.dart';
import 'package:insta_app/services/api_interface.dart';
import 'package:insta_app/services/entities/default_response.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/tools.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  File? postImage;

  CreatePostScreen({Key? key, this.postImage}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  ApiInterface? apiInterface;
  TextEditingController caption = TextEditingController();
  bool _hideComment = false;
  bool _hideLike = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      apiInterface = ApiInterface(context);

      setState(() {});
    });
  }

  void createPost({String? image}) async {
    Map<String, String> headers = HashMap();
    Map<String, String> body = HashMap();
    Map<String, String> file = HashMap();

    var token = stdin.readLineSync();
    if (context.read<TokenProvider>().token != null) {
      token = context.read<TokenProvider>().token;
      headers["Authorization"] = "Bearer " + token!;
      headers["Content-Type"] = "multipart/form-data";
    }

    body['caption'] = caption.text;
    body['hide_comment'] = _hideComment.toString();
    body['hide_like'] = _hideLike.toString();
    file['post'] = image!;

    apiInterface!.doCreatePost(
        body: body,
        files: file,
        header: headers,
        onUnhandleError: (e, response) {
          print(e);
        },
        onFinish: (response) async {
          print(response);
          Navigator.pop(context);
          var responseData = await response.stream.toBytes();
          var responseString = String.fromCharCodes(responseData);
          print(responseString);

          DefaultResponse defaultResponse =
              DefaultResponse.fromJson(json.decode(responseString));

          if (response.statusCode == 200) {
            context.read<PostProvider>().getPosts(context, resetPage: true);

            await showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (context) => CustomAlertDialog(
                title: "Success",
                message: defaultResponse.message!,
                buttonText: "OK",
                onConfirm: () {
                  Navigator.pop(context);
                },
              ),
            ).then((v) {
              Navigator.pop(context);
            });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.white,
      appBar: DefaultAppBar(
        height: 66.h(context),
        title: "New Post",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w(context),
          vertical: 24.h(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150.w(context),
              height: 150.h(context),
              child: Container(
                padding: EdgeInsets.only(right: 10.w(context)),
                child: Image.file(widget.postImage!),
              ),
            ),
            TextArea(
              controller: caption,
              hint: "Caption",
            ).addMarginTop(8.h(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hide like and view count on this post",
                  textAlign: TextAlign.center,
                  style: Themes(context).black14,
                ),
                CupertinoSwitch(
                  value: _hideLike,
                  onChanged: (value) {
                    setState(() {
                      _hideLike = value;
                    });
                  },
                )
              ],
            ).addMarginTop(8.h(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Turn off commenting",
                  textAlign: TextAlign.center,
                  style: Themes(context).black14,
                ),
                CupertinoSwitch(
                  value: _hideComment,
                  onChanged: (value) {
                    setState(() {
                      _hideComment = value;
                    });
                  },
                )
              ],
            ).addMarginTop(8.h(context)),
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
            child: PrimaryButton(
              padding: EdgeInsets.symmetric(
                horizontal: 6.w(context),
                vertical: 16.w(context),
              ),
              onTap: caption.text.isEmpty
                  ? null
                  : () {
                      Tools.showProgressDialog(context);
                      createPost(image: widget.postImage!.path);
                    },
              text: "POST",
            ),
          ),
        ],
      ),
    );
  }
}
