import 'package:insta_app/components/buttons/primary_button.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';

class ModalPickerPost extends StatelessWidget {
  final VoidCallback? onTakePhoto;
  final VoidCallback? onSearchGallery;

  const ModalPickerPost({
    Key? key,
    this.onTakePhoto,
    this.onSearchGallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 24.h(context),
        horizontal: 16.w(context),
      ),
      height: 168.h(context),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryButton(
            onTap: onTakePhoto,
            lightButton: false,
            text: "TAKE A PHOTO",
          ),
          PrimaryButton(
            elevateButtonOnTap: false,
            lightButton: true,
            onTap: onSearchGallery,
            color: Themes.white,
            text: "TAKE FROM GALLERY",
            borderColor: Themes.stroke,
            textColor: Themes.black,
          ).addMarginTop(16.h(context)),
        ],
      ),
    );
  }
}
