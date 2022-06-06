// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:flutter/material.dart';

class CustomProgressDialog extends StatelessWidget {
  CustomProgressDialog({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  final String title;
  final String message;

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
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title, style: Themes(context).blackBold16),
              Container(
                margin: EdgeInsets.only(top: 18.h(context)),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 18.w(context),
                      height: 18.w(context),
                      child: CircularProgressIndicator(),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 18.w(context)),
                        child: Text(message, style: Themes(context).black14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
