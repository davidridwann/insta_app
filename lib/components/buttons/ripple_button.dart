// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:flutter/material.dart';

class RippleButton extends StatefulWidget {
  final String? text;
  final VoidCallback? onTap;
  final Color? rippleColor;
  final Color? color;
  final Color? textColor;
  final Widget? child;
  final EdgeInsets? padding;
  final Border? border;
  final double? radius;
  final bool? enableShadow;
  final bool? lightButton;
  final MainAxisAlignment? axisAlignment;

  RippleButton({
    Key? key,
    this.text,
    this.onTap,
    this.color,
    this.rippleColor,
    this.textColor,
    this.child,
    this.padding,
    this.border,
    this.enableShadow = true,
    this.radius,
    this.lightButton = false,
    this.axisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  _RippleButtonState createState() => _RippleButtonState();
}

class _RippleButtonState extends State<RippleButton> {
  Color? rippleColor;
  Color? color;
  Color? textColor;
  EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    if (widget.rippleColor == null) {
      rippleColor = widget.lightButton!
          ? Colors.black.withOpacity(0.3)
          : Colors.white.withOpacity(0.3);
    } else {
      rippleColor = widget.rippleColor;
    }

    if (widget.color == null) {
      color = Themes.primary;
    } else {
      color = widget.color;
    }

    if (widget.textColor == null) {
      textColor = Colors.white;
    } else {
      textColor = widget.textColor;
    }

    if (widget.padding == null) {
      padding = EdgeInsets.all(16.w(context));
    } else {
      padding = widget.padding;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      decoration: BoxDecoration(
        border: widget.border,
        color: widget.onTap != null ? color : Themes.stroke,
        borderRadius: BorderRadius.circular(widget.radius ?? 6.w(context)),
        boxShadow: widget.onTap != null
            ? [
                if (widget.enableShadow!)
                  BoxShadow(
                    color: color!.withOpacity(0.5),
                    offset: Offset(0, 4),
                    blurRadius: 12,
                  )
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius ?? 6.w(context)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            highlightColor: rippleColor!.withOpacity(0.2),
            splashColor: rippleColor,
            onTap: widget.onTap,
            child: Padding(
              padding: padding!,
              child: Center(
                child: widget.child ??
                    Text(
                      widget.text!,
                      style: Themes(context).white14!.apply(
                            color: widget.onTap != null
                                ? textColor
                                : Themes.black.withOpacity(0.6),
                          ),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
