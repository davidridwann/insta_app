// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:insta_app/components/buttons/primary_button.dart';
import 'package:insta_app/components/dialogs/custom_alert_dialog.dart';
import 'package:insta_app/components/textareas/password_textarea.dart';
import 'package:insta_app/components/textareas/textarea.dart';
import 'package:insta_app/data/providers/token_provider.dart';
import 'package:insta_app/data/providers/user_provider.dart';
import 'package:insta_app/services/api_interface.dart';
import 'package:insta_app/services/entities/login_response.dart';
import 'package:insta_app/ui/layout_screen.dart';
import 'package:insta_app/ui/register_screen.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/tools.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, TextEditingController> textControllers = {};
  bool enable = false;
  bool splashLoading = false;
  ApiInterface? apiInterface;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    Tools.changeStatusbarIconColor(
      darkIcon: false,
    );

    textControllers["email"] = TextEditingController();
    textControllers["password"] = TextEditingController();

    for (String key in textControllers.keys) {
      textControllers[key]?.addListener(() {
        setState(() {
          bool isEmail = Tools.isEmail(textControllers["email"]!.text);
          enable = textControllers.values
                  .toList()
                  .where((element) => element.text.isEmpty)
                  .isEmpty &&
              isEmail;
        });
      });
    }

    SchedulerBinding.instance?.addPostFrameCallback((_) {
      apiInterface = ApiInterface(context);

      Future.delayed(Duration(seconds: 2), () async {
        String? token = await context.read<TokenProvider>().loadToken();

        if (token != null) {
          await context.read<UserProvider>().loadLocalUser();
          Tools.navigateRefresh(
            context,
            LayoutScreen(),
            "/layout",
          );
        } else {
          setState(() {
            splashLoading = true;
          });
        }
      });
    });
  }

  void doLogin() {
    var body = {};

    for (String key in textControllers.keys) {
      body[key] = textControllers[key]?.text;
    }

    apiInterface?.doLogin(
      body: body,
      onUnhandleError: (e, response) {
        print(e);
      },
      onFinish: (response) async {
        var tokenReponse = stdin.readLineSync();
        var messageReponse = stdin.readLineSync();

        LoginReponse loginReponse =
            LoginReponse.fromJson(jsonDecode(response.body));

        if (response.statusCode == 200) {
          tokenReponse = loginReponse.token;
          context.read<TokenProvider>().saveToken(tokenReponse!);
          await context.read<UserProvider>().loadNetworkUser(context,
              onFinish: () {
            if (loginReponse.data != null) {
              Tools.navigateRefresh(
                context,
                LayoutScreen(),
                "/layout",
              );
            }
          });
        } else {
          messageReponse = loginReponse.message;
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (dialogContext) => CustomAlertDialog(
              onConfirm: () {
                Navigator.pop(context);
              },
              title: "Terjadi Kesalahan",
              message: messageReponse!,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              color: Themes.white),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AnimatedContainer(
                    alignment: Alignment.center,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 300),
                    height: splashLoading ? 40.hp(context) : 100.hp(context),
                    child: Container(
                      child: Text(
                        "Insta App",
                        textAlign: TextAlign.center,
                        style: Themes(context).loginTitle,
                      )
                          .addSymmetricMargin(
                            vertical: 8.w(context),
                          )
                          .addMarginTop(
                              splashLoading ? 160.h(context) : 70.h(context)),
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment.center,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 300),
                    height: splashLoading ? 80.hp(context) : 0,
                    decoration: BoxDecoration(
                      color: Themes.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.w(context)),
                        topRight: Radius.circular(8.w(context)),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w(context),
                        vertical: 24.h(context),
                      ),
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextArea(
                              controller: textControllers["email"],
                              hint: "Email",
                              inputType: TextInputType.emailAddress,
                            ).addMarginTop(4.h(context)),
                            PasswordTextarea(
                              controller: textControllers["password"]!,
                              hint: "Password",
                            ).addMarginTop(4.h(context)),
                            PrimaryButton(
                              enable: enable,
                              onTap: () {
                                Tools.showProgressDialog(context);
                                doLogin();
                              },
                              text: "Log In",
                            ).addMarginTop(24.h(context)),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    textAlign: TextAlign.center,
                                    style: Themes(context).gray12,
                                  ).addMarginRight(5.h(context)),
                                  InkWell(
                                    child: Text(
                                      "Sign Up",
                                      textAlign: TextAlign.center,
                                      style: Themes(context).primaryBold12,
                                    ),
                                    onTap: () {
                                      Tools.navigatePush(
                                          context, RegisterScreen());
                                    },
                                  ),
                                ],
                              ),
                            ).addMarginTop(10.h(context))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
