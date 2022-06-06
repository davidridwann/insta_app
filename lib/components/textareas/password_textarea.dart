// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:insta_app/components/buttons/ripple_button.dart';
import 'package:insta_app/components/textareas/textarea.dart';
import 'package:insta_app/image_routing.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordTextarea extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;
  final bool? visibilitButton;
  final BoxShadow? shadow;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  PasswordTextarea({
    Key? key,
    this.hint,
    this.controller,
    this.shadow,
    this.padding,
    this.borderRadius,
    this.visibilitButton = true,
  }) : super(key: key);

  @override
  _PasswordTextareaState createState() => _PasswordTextareaState();
}

class _PasswordTextareaState extends State<PasswordTextarea> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return TextArea(
      controller: widget.controller,
      secureInput: !visible,
      hint: widget.hint,
      endIcon: widget.visibilitButton!
          ? RippleButton(
              padding: EdgeInsets.all(8.w(context)),
              radius: 32,
              lightButton: true,
              color: Colors.white,
              onTap: () {
                setState(() {
                  visible = !visible;
                });
              },
              child: SvgPicture.asset(
                visible
                    ? ImgRoute.assetsIconsIcEyeOpen
                    : ImgRoute.assetsIconsIcEyeClose,
                width: 24.w(context),
                height: 24.w(context),
              ),
            ).addMarginRight(4.w(context))
          : null,
      borderRadius: widget.borderRadius,
      shadow: widget.shadow,
      padding: widget.padding,
    );
  }
}
