// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:insta_app/components/buttons/ripple_button.dart';
import 'package:insta_app/image_routing.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DefaultAppBar extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onTapBack;
  final double? height;
  final Widget? action;
  final String? title;
  final Color color;
  final bool showDivider;

  DefaultAppBar({
    Key? key,
    this.onTapBack,
    this.height,
    this.action,
    this.title,
    this.color = Colors.white,
    this.showDivider = true,
  }) : super(key: key);

  @override
  _DefaultAppBarState createState() => _DefaultAppBarState();

  @override
  Size get preferredSize => Size(double.infinity, height!);
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Themes.white,
          height: 20.h(context),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w(context),
            vertical: 6.w(context),
          ),
          color: Themes.white,
          width: double.infinity,
          height: widget.height! - 20.h(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RippleButton(
                    radius: 32.w(context),
                    padding: EdgeInsets.all(8.w(context)),
                    lightButton: true,
                    color: Themes.white,
                    onTap: () {
                      if (widget.onTapBack != null) {
                        widget.onTapBack!();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: SvgPicture.asset(
                      ImgRoute.assetsIconsIcArrowLeft,
                    ),
                  ),
                  Text(
                    widget.title!,
                    style: Themes(context).blackBold14,
                  ).addMarginLeft(16.w(context)),
                ],
              ),
              if (widget.action != null) widget.action!
            ],
          ),
        ),
        if (widget.showDivider)
          Container(
            width: double.infinity,
            height: 1,
            color: Themes.stroke,
          )
      ],
    );
  }
}
