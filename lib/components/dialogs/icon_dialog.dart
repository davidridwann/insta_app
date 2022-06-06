// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:insta_app/components/buttons/primary_button.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';

class IconDialog extends StatelessWidget {
  IconDialog({
    Key? key,
    this.title,
    this.message,
    this.onConfirm,
    this.buttonText = "OK",
    @required this.icon,
  }) : super(key: key);

  final String? title;
  final String? message;
  final VoidCallback? onConfirm;
  final String buttonText;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.w(context)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 24.w(context),
            vertical: 40.h(context),
          ),
          width: 70.wp(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon!,
              Text(
                title!,
                textAlign: TextAlign.center,
                style: Themes(context).blackBold16,
              ).addMarginTop(16.h(context)),
              Container(
                margin: EdgeInsets.only(top: 4.h(context)),
                child: Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: Themes(context).black14!.apply(color: Themes.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24.h(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    PrimaryButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h(context),
                      ),
                      text: buttonText,
                      onTap: onConfirm,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
