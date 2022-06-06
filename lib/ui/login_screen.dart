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
          print('ok');
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
              print('ok');
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Insta App",
                          textAlign: TextAlign.center,
                          style: Themes(context).blackBold14,
                        ).addSymmetricMargin(
                          vertical: 8.w(context),
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment.center,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 300),
                    height: splashLoading ? 60.hp(context) : 0,
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
                            Text(
                              "Email",
                              style: Themes(context).blackBold12,
                            ),
                            TextArea(
                              controller: textControllers["email"],
                              hint: "masukkan email anda",
                              inputType: TextInputType.emailAddress,
                            ).addMarginTop(4.h(context)),
                            Text(
                              "Password",
                              style: Themes(context).blackBold12,
                            ).addMarginTop(16.h(context)),
                            PasswordTextarea(
                              controller: textControllers["password"]!,
                              hint: "masukkan password",
                            ).addMarginTop(4.h(context)),
                            PrimaryButton(
                              enable: enable,
                              onTap: () {
                                Tools.showProgressDialog(context);
                                doLogin();
                                // showDialog(
                                //   context: context,
                                //   child: OptionsDialog(
                                //     title: "Login Sebagai",
                                //     options: [
                                //       "GA",
                                //       "Admin Vendor",
                                //       "Pegawai Vendor",
                                //       "Pelapor",
                                //     ],
                                //     onOptionSelected: (value) {
                                //       Navigator.pop(context);

                                //       switch (value) {
                                //         case "GA":
                                //           context
                                //               .read<RoleProvider>()
                                //               .changeRole("ga");
                                //           Tools.navigatePush(
                                //             context,
                                //             HomeGeneralAffair(),
                                //           );
                                //           break;
                                //         case "Admin Vendor":
                                //           context
                                //               .read<RoleProvider>()
                                //               .changeRole("av");
                                //           Tools.navigatePush(
                                //             context,
                                //             HomeAdminVendor(),
                                //           );
                                //           break;
                                //         case "Pegawai Vendor":
                                //           context
                                //               .read<RoleProvider>()
                                //               .changeRole("ev");
                                //           Tools.navigatePush(
                                //             context,
                                //             HomeEmployeeVendor(),
                                //           );
                                //           break;
                                //         case "Pelapor":
                                //           context
                                //               .read<RoleProvider>()
                                //               .changeRole("re");
                                //           Tools.navigatePush(
                                //             context,
                                //             HomeReporter(),
                                //           );
                                //           break;
                                //       }
                                //     },
                                //   ),
                                // );
                              },
                              text: "MASUK",
                            ).addMarginTop(24.h(context)),
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
