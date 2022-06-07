// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_app/components/buttons/primary_button.dart';
import 'package:insta_app/components/commons/default_appbar.dart';
import 'package:insta_app/components/commons/flat_card.dart';
import 'package:insta_app/components/dialogs/custom_alert_dialog.dart';
import 'package:insta_app/components/textareas/password_textarea.dart';
import 'package:insta_app/components/textareas/textarea.dart';
import 'package:insta_app/data/providers/token_provider.dart';
import 'package:insta_app/image_routing.dart';
import 'package:insta_app/services/api_interface.dart';
import 'package:insta_app/services/entities/default_response.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/tools.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ApiInterface? apiInterface;
  String selectedType = "habis_pakai";
  String selectedStatus = "baru";
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      apiInterface = ApiInterface(context);

      setState(() {});
    });
  }

  void createItem() async {
    Map<String, String> headers = HashMap();
    Map<String, String> body = HashMap();

    var token = stdin.readLineSync();
    if (context.read<TokenProvider>().token != null) {
      token = context.read<TokenProvider>().token;
      headers["Authorization"] = "Bearer " + token!;
    }
    body['name'] = name.text;
    body['username'] = username.text;
    body['email'] = email.text;
    body['password'] = password.text;

    apiInterface!.doRegisterAccount(
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
        title: "Register Account",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w(context),
          vertical: 24.h(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: FlatCard(
                padding: EdgeInsets.all(18.w(context)),
                color: Themes.greyBg,
                borderRadius: BorderRadius.circular(50),
                width: 150.w(context),
                height: 150.w(context),
                child: SvgPicture.asset(
                  ImgRoute.assetsIconsIcProfile,
                ),
              ),
            ),
            TextArea(
              controller: name,
              hint: "Name",
            ).addMarginTop(4.h(context)),
            TextArea(
              controller: username,
              hint: "Username",
            ).addMarginTop(4.h(context)),
            TextArea(
              controller: email,
              hint: "Email",
              inputType: TextInputType.emailAddress,
            ).addMarginTop(4.h(context)),
            PasswordTextarea(
              controller: password,
              hint: "Password",
            ).addMarginTop(4.h(context)),
            PrimaryButton(
              onTap: name.text.isEmpty ||
                      username.text.isEmpty ||
                      email.text.isEmpty ||
                      password.text.isEmpty
                  ? null
                  : () {
                      Tools.showProgressDialog(context);
                      createItem();
                    },
              text: "REGISTER",
            ).addMarginTop(20.h(context))
          ],
        ),
      ),
    );
  }
}
