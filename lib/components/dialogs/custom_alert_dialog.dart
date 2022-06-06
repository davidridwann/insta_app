import 'package:insta_app/components/buttons/primary_button.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  CustomAlertDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.buttonText = "OK",
  }) : super(key: key);

  final String title;
  final String message;
  final VoidCallback onConfirm;
  final String buttonText;

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
          padding: EdgeInsets.all(24.w(context)),
          width: 80.wp(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title, style: Themes(context).blackBold16),
              Container(
                margin: EdgeInsets.only(top: 4.h(context)),
                child: Text(
                  message,
                  style: Themes(context).black14!.apply(color: Themes.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24.h(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    PrimaryButton(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w(context),
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
