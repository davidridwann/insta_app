// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:insta_app/components/textareas/textarea.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';

class DynamicForm extends StatefulWidget {
  final String? label;
  final String? item;
  final Function(List<File> values)? value;

  DynamicForm({
    Key? key,
    this.label,
    this.item,
    this.value,
  }) : super(key: key);

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  List<File> values = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w(context),
          vertical: 24.h(context),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.label!,
            style: Themes(context).blackBold14,
          ),
          TextArea(
            hint: "Jumlah terakhir setelah pemakaian",
            onChangedText: (text) {
              if (text != null) {
                setState(() {
                  var finalValue = text + '.' + widget.item!;
                  values.add(File(finalValue));
                  widget.value!(values);
                });
              }
            },
          ).addMarginTop(4.h(context)),
        ]));
  }
}
