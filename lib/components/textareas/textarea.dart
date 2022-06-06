import 'package:insta_app/components/commons/flat_card.dart';
import 'package:insta_app/components/dialogs/custom_alert_dialog.dart';
import 'package:insta_app/image_routing.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TextArea extends StatefulWidget {
  final String? hint;
  final Widget? icon;
  final Widget? endIcon;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatter;
  final bool? secureInput;
  final int? maxLenght;
  final int? maxLine;
  final Function(String value)? onChangedText;
  final Function(String value)? onSubmitText;
  final double? width;
  final double? height;
  final TextCapitalization textCapitalization;
  final MainAxisAlignment mainAxisAlignment;
  final Color? color;
  final bool enable;
  final bool error;
  final String errorMessage;
  final bool autoFocus;
  final TextAlign textAlign;
  final BoxShadow? shadow;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;

  TextArea({
    Key? key,
    this.hint,
    this.icon,
    this.endIcon,
    this.controller,
    this.inputType,
    this.secureInput = false,
    this.inputFormatter,
    this.maxLenght,
    this.maxLine = 1,
    this.onChangedText,
    this.width,
    this.height,
    this.shadow,
    this.padding,
    this.borderRadius,
    this.onSubmitText,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.color,
    this.enable = true,
    this.error = false,
    this.autoFocus = false,
    this.errorMessage = "",
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  _TextAreaState createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  @override
  Widget build(BuildContext context) {
    return FlatCard(
      border: Border.all(
        color: Themes.stroke,
      ),
      color: widget.color,
      width: widget.width,
      height: widget.height,
      child: Row(
        children: <Widget>[
          if (widget.icon != null) widget.icon! else Container(),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: widget.mainAxisAlignment,
              children: <Widget>[
                Theme(
                  data: ThemeData(
                    // ignore: deprecated_member_use
                    textSelectionColor: Themes.primary.withOpacity(0.3),
                  ),
                  child: TextField(
                    textAlign: widget.textAlign,
                    autofocus: widget.autoFocus,
                    enabled: widget.enable,
                    minLines: 1,
                    maxLines: widget.maxLine,
                    textCapitalization: widget.textCapitalization,
                    textInputAction: widget.textInputAction,
                    onSubmitted: (value) {
                      if (widget.onSubmitText != null) {
                        widget.onSubmitText!(value);
                      }
                    },
                    onChanged: (value) {
                      if (widget.onChangedText != null) {
                        widget.onChangedText!(value);
                      }
                    },
                    obscureText: widget.secureInput!,
                    controller: widget.controller,
                    keyboardType: widget.inputType,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: Responsive(context).f(14),
                        color: Themes.black,
                      ),
                    ),
                    inputFormatters: widget.inputFormatter,
                    maxLength: widget.maxLenght,
                    cursorColor: Themes.primary,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 16.w(context),
                        right: 16.w(context),
                        top: 16.h(context),
                        bottom: 16.h(context),
                      ),
                      hintText: widget.hint,
                      hintStyle: Themes(context)
                          .black14!
                          .apply(color: Themes.black.withOpacity(0.3)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.endIcon != null) widget.endIcon! else Container(),
          if (widget.error)
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlertDialog(
                      title: "Form Error",
                      message: widget.errorMessage,
                      buttonText: "OK",
                      onConfirm: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 12.w(context)),
                child: SvgPicture.asset(
                  ImgRoute.assetsIconsIcCaution,
                  color: Themes.red,
                  width: 24.w(context),
                  height: 24.w(context),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
