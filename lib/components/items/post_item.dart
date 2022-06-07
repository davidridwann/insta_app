import 'package:insta_app/components/commons/flat_card.dart';
import 'package:insta_app/components/commons/popup_menu.dart';
import 'package:insta_app/components/dialogs/question_dialog.dart';
import 'package:insta_app/image_routing.dart';
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

  const PostItem({
    Key? key,
    this.onTap,
    this.showOption = false,
    this.onDelete,
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

    return FlatCard(
      border: Border.all(color: Themes.stroke),
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
                      widget.item == null ? "" : widget.item!.caption!,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 12.f(context),
                          color: Themes.red,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (optionShow)
                      PopupMenu(
                        icon: ImgRoute.assetsIconsIcMenu,
                        menus: [
                          MenuItem(
                            text: "Hapus",
                            value: "delete",
                            color: Themes.red,
                          ),
                        ],
                        onSelected: (value) {
                          switch (value) {
                            case "delete":
                              showDialog(
                                context: context,
                                builder: (dialogContext) => QuestionDialog(
                                  title: "Hapus Barang",
                                  message: "Yakin ingin menghapus barang?",
                                  positiveText: "Hapus",
                                  negativeText: "Batal",
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
                          }
                        },
                      ),
                  ],
                ),
                Text(
                  widget.item == null ? "" : widget.item!.caption!,
                  style: Themes(context).blackBold14,
                ),
                Text(
                  widget.item == null ? "" : widget.item!.caption!,
                  style: Themes(context).black14,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.item == null
                          ? ""
                          : widget.item!.caption!.toString() + " total stok",
                      style: Themes(context).gray12,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 8.w(context),
                        right: 8.w(context),
                      ),
                      width: 4.w(context),
                      height: 4.w(context),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Themes.grey,
                      ),
                    ),
                    Text(
                      widget.item == null
                          ? ""
                          : "Satuan " + widget.item!.caption!,
                      style: Themes(context).gray12,
                    ),
                  ],
                ).addMarginTop(8.h(context)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.item == null
                          ? ""
                          : DateFormat("d MMM yyyy", "id")
                              .format(widget.item!.createdAt!),
                      style: Themes(context).gray12,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 8.w(context),
                        right: 8.w(context),
                      ),
                      width: 4.w(context),
                      height: 4.w(context),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Themes.grey,
                      ),
                    ),
                    Text(
                      widget.item != null
                          ? "Spesifikasi " + widget.item!.caption!
                          : '-',
                      style: Themes(context).gray12,
                    ),
                  ],
                ).addMarginTop(4.h(context))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
