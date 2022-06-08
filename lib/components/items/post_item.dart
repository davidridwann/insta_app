import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_app/components/commons/flat_card.dart';
import 'package:insta_app/components/commons/popup_menu.dart';
import 'package:insta_app/components/dialogs/question_dialog.dart';
import 'package:insta_app/image_routing.dart';
import 'package:insta_app/services/api_service.dart';
import 'package:insta_app/services/entities/post_response.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PostItem extends StatefulWidget {
  final VoidCallback? onTap;
  final Post? item;
  final bool showOption;
  final VoidCallback? onDelete;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onEdit;

  const PostItem({
    Key? key,
    this.onTap,
    this.showOption = false,
    this.onDelete,
    this.onLike,
    this.onComment,
    this.onEdit,
    this.item,
  }) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    bool optionShow = widget.showOption;
    VoidCallback? doDelete = widget.onDelete;
    VoidCallback? doLike = widget.onLike;
    VoidCallback? doEdit = widget.onEdit;
    VoidCallback? doComment = widget.onComment;

    return FlatCard(
      child: Material(
        borderRadius: BorderRadius.circular(4.w(context)),
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.all(16.w(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.item == null ? "" : widget.item!.created_by!,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 12.f(context),
                          color: Themes.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (optionShow)
                      PopupMenu(
                        icon: ImgRoute.assetsIconsIcMenu,
                        menus: [
                          MenuItem(
                            text: "Delete",
                            value: "delete",
                            color: Themes.red,
                          ),
                          MenuItem(
                            text: "Edit",
                            value: "edit",
                            color: Themes.black,
                          ),
                        ],
                        onSelected: (value) {
                          switch (value) {
                            case "delete":
                              showDialog(
                                context: context,
                                builder: (dialogContext) => QuestionDialog(
                                  title: "Delete Post",
                                  message: "Are you sure you want delete post?",
                                  positiveText: "OK",
                                  negativeText: "CANCEL",
                                  negativeAction: true,
                                  onConfirm: () {
                                    doDelete!();
                                  },
                                  onCancel: () {
                                    Navigator.pop(context, false);
                                  },
                                ),
                              );
                              break;
                            case "edit":
                              doEdit!();
                              break;
                          }
                        },
                      ),
                  ],
                ),
                SizedBox(
                    child: CachedNetworkImage(
                        imageUrl: ApiService.realUrl + widget.item!.post!,
                        width: MediaQuery.of(context).size.width,
                        height: 250.h(context),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                              child: Text('Loading..'),
                            ).addMarginTop(45.h(context)),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error))),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.item!.hide_like == false
                        ? InkWell(
                            onTap: () {
                              doLike!();
                            },
                            borderRadius: BorderRadius.circular(50),
                            child: SvgPicture.asset(
                              ImgRoute.assetsIconsIcLike,
                              width: 24.w(context),
                              height: 24.w(context),
                              color: widget.item!.is_like! == true
                                  ? Themes.red
                                  : Themes.black.withOpacity(0.5),
                            ),
                          ).addMarginRight(10.w(context))
                        : Container(),
                    widget.item!.hide_comment == false
                        ? InkWell(
                            onTap: () {
                              doComment!();
                            },
                            child: SvgPicture.asset(
                              ImgRoute.assetsIconsIcComment,
                              width: 26.w(context),
                              height: 26.w(context),
                              color: Themes.black.withOpacity(0.5),
                            ),
                          )
                        : Container(),
                  ],
                ).addMarginTop(8.h(context)),
                widget.item!.hide_like == false
                    ? Text(
                        widget.item!.total_like!.toString() + ' Likes',
                        style: Themes(context).blackBold12,
                      ).addMarginRight(5.w(context))
                    : Container(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.item!.created_by!,
                      style: Themes(context).blackBold12,
                    ).addMarginRight(5.w(context)),
                    Text(
                      widget.item!.caption!,
                      style: Themes(context).gray12,
                    ),
                  ],
                ).addMarginTop(4.h(context)),
                Text(
                  widget.item == null
                      ? ""
                      : DateFormat("d MMM yyyy", "id")
                          .format(widget.item!.createdAt!),
                  style: Themes(context).gray12,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
