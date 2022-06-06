// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItem {
  String? text;
  dynamic value;
  Color? color;

  MenuItem({
    this.text,
    this.value,
    this.color,
  });
}

class PopupMenu extends StatelessWidget {
  final String? icon;
  final Function(String value)? onSelected;
  final List<MenuItem>? menus;

  PopupMenu({Key? key, this.icon, this.onSelected, this.menus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.w(context))),
        side: BorderSide(
          color: Themes.stroke,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8.w(context)),
        child: SvgPicture.asset(
          icon!,
          width: 24.w(context),
          height: 24.w(context),
        ),
      ),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return menus!
            .map(
              (e) => PopupMenuItem<String>(
                value: e.value,
                child: Text(
                  e.text!,
                  style: Themes(context, withLineHeight: false).black14!.apply(
                        color: e.color ?? Themes.black,
                      ),
                ),
              ),
            )
            .toList();
      },
    );
  }
}
