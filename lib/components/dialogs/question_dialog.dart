import 'package:insta_app/components/buttons/primary_button.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';

class QuestionDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String positiveText;
  final String negativeText;
  final bool negativeAction;

  QuestionDialog({
    Key? key,
    this.title,
    this.message,
    this.onConfirm,
    this.onCancel,
    this.positiveText = "Ok",
    this.negativeText = "Batalkan",
    this.negativeAction = false,
  }) : super(key: key);

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
              if (title != null)
                Text(title!, style: Themes(context).blackBold16),
              Container(
                margin: EdgeInsets.only(top: 4.h(context)),
                child: Text(
                  message!,
                  style: Themes(context).black14!.apply(color: Themes.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.h(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    PrimaryButton(
                      padding: EdgeInsets.symmetric(vertical: 12.h(context)),
                      elevateButtonOnTap: false,
                      lightButton: true,
                      onTap: onCancel,
                      color: Themes.white,
                      text: negativeText,
                      borderColor: Themes.stroke,
                      textColor: Themes.black,
                    ).addExpanded,
                    Container(
                      width: 16.w(context),
                    ),
                    PrimaryButton(
                      padding: EdgeInsets.symmetric(vertical: 12.h(context)),
                      onTap: onConfirm,
                      lightButton: false,
                      color: negativeAction ? Themes.red : Themes.primary,
                      text: positiveText,
                    ).addExpanded,
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
