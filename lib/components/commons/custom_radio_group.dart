import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';

class CustomRadioButton {
  String? text;
  int? index;
  bool selected;

  CustomRadioButton({
    this.text,
    this.index,
    this.selected = false,
  });
}

class CustomRadioController {
  final int initialIndex;
  int selected = 0;

  CustomRadioController({this.initialIndex = 0});

  void setSelected(int selected) {
    this.selected = selected;
  }
}

class CustomRadioGroup extends StatefulWidget {
  final Axis orientation;
  final List<String>? options;
  final Function(CustomRadioButton radio)? onChangeSelection;
  final CustomRadioController? controller;

  CustomRadioGroup({
    Key? key,
    this.controller,
    this.orientation = Axis.vertical,
    @required this.options,
    @required this.onChangeSelection,
  }) : super(key: key);

  @override
  _CustomRadioGroupState createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  List<CustomRadioButton> options = [];

  @override
  void initState() {
    super.initState();
    for (String text in widget.options!) {
      options.add(CustomRadioButton(
        index: widget.options!.indexOf(text),
        text: text,
      ));
    }

    if (widget.controller != null) {
      options[widget.controller!.initialIndex].selected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller != null) {
      options.forEach((element) {
        element.selected = false;
      });
      options[widget.controller!.selected].selected = true;
    }

    return widget.orientation == Axis.vertical
        ? Column(
            children: options.map((e) {
              return GestureDetector(
                onTap: () {
                  // if (widget.controller != null) {
                  //   widget.controller.setSelected(e.index);
                  // }
                  widget.onChangeSelection!(e);
                  setState(() {});
                },
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8.w(context)),
                      width: 24.w(context),
                      height: 24.h(context),
                      decoration: BoxDecoration(
                        color: Themes.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Themes.stroke),
                      ),
                      child: Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          width: e.selected ? 8.w(context) : 24.w(context),
                          height: e.selected ? 8.w(context) : 24.w(context),
                          decoration: BoxDecoration(
                            color: Themes.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      e.text!,
                      style: Themes(context).black14,
                    )
                  ],
                ),
              ).addMarginTop(16.h(context));
            }).toList(),
          )
        : Row(
            children: options.map((e) {
              return GestureDetector(
                onTap: () {
                  // if (widget.controller != null) {
                  //   widget.controller.setSelected(e.index);
                  // }
                  widget.onChangeSelection!(e);
                  setState(() {});
                },
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8.w(context)),
                      width: 24.w(context),
                      height: 24.h(context),
                      decoration: BoxDecoration(
                        color: Themes.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Themes.stroke),
                      ),
                      child: Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          width: e.selected ? 8.w(context) : 24.w(context),
                          height: e.selected ? 8.w(context) : 24.w(context),
                          decoration: BoxDecoration(
                            color: Themes.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      e.text!,
                      style: Themes(context, withLineHeight: false).black14,
                    )
                  ],
                ),
              ).addMarginRight(16.h(context));
            }).toList(),
          );
  }
}
