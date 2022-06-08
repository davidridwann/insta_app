// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_app/components/buttons/primary_button.dart';
import 'package:insta_app/components/commons/flat_card.dart';
import 'package:insta_app/components/commons/popup_menu.dart';
import 'package:insta_app/components/dialogs/question_dialog.dart';
import 'package:insta_app/data/providers/page_provider.dart';
import 'package:insta_app/data/providers/post_provider.dart';
import 'package:insta_app/data/providers/token_provider.dart';
import 'package:insta_app/data/providers/user_provider.dart';
import 'package:insta_app/image_routing.dart';
import 'package:insta_app/services/api_interface.dart';
import 'package:insta_app/services/api_service.dart';
import 'package:insta_app/services/entities/login_response.dart';
import 'package:insta_app/services/entities/post_response.dart';
import 'package:insta_app/ui/login_screen.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/tools.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ApiInterface? apiInterface;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      context.read<PostProvider>().getPosts(context, resetPage: true);
    });
  }

  Widget build(BuildContext context) {
    User? user = context.watch<UserProvider>().user;
    List<Post> posts = context.watch<PostProvider>().posts;

    String? name = '-';
    String? username = '-';
    String? email = '-';

    if (user != null) {
      name = user.name;
      username = user.username;
      email = user.email;
    }

    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                username!,
                style: Themes(context).blackBold18,
              ),
              PopupMenu(
                icon: ImgRoute.assetsIconsIcMenu,
                menus: [
                  MenuItem(
                    text: "Log out",
                    value: "logout",
                    color: Themes.red,
                  ),
                ],
                onSelected: (value) {
                  switch (value) {
                    case "logout":
                      showDialog(
                        context: context,
                        builder: (dialogContext) => QuestionDialog(
                          title: "Log out",
                          message: "Are you sure you want to log out?",
                          positiveText: "OK",
                          negativeText: "CANCEL",
                          negativeAction: true,
                          onConfirm: () {
                            Navigator.pop(context);
                            context.read<UserProvider>().logoutUser();
                            context.read<PageProvider>().toPage(0);
                            context.read<TokenProvider>().resetToken();

                            Tools.navigateRefresh(
                                context, LoginScreen(), "/login");
                          },
                          onCancel: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                      break;
                  }
                },
              ),
            ],
          ).addMarginOnly(
            top: 48.h(context),
            left: 16.w(context),
            right: 8.w(context),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h(context),
                          horizontal: 16.w(context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FlatCard(
                                  color: Themes.greyBg,
                                  borderRadius: BorderRadius.circular(50),
                                  width: 80.w(context),
                                  height: 80.w(context),
                                  child: SvgPicture.asset(
                                    ImgRoute.assetsIconsIcProfile,
                                  ),
                                ).addMarginRight(16.h(context)),
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: Themes(context).blackBold16,
                                    )
                                        .addMarginTop(4.h(context))
                                        .addMarginLeft(10.h(context)),
                                    Text(
                                      "Posts",
                                      style: Themes(context).black14,
                                    )
                                        .addMarginTop(4.h(context))
                                        .addMarginLeft(10.h(context)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: Themes(context).blackBold16,
                                    )
                                        .addMarginTop(4.h(context))
                                        .addMarginLeft(10.h(context)),
                                    Text(
                                      "Followers",
                                      style: Themes(context).black14,
                                    )
                                        .addMarginTop(4.h(context))
                                        .addMarginLeft(10.h(context)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "0",
                                      style: Themes(context).blackBold16,
                                    )
                                        .addMarginTop(4.h(context))
                                        .addMarginLeft(10.h(context)),
                                    Text(
                                      "Following",
                                      style: Themes(context).black14,
                                    )
                                        .addMarginTop(4.h(context))
                                        .addMarginLeft(10.h(context)),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  name!,
                                  style: Themes(context).black12,
                                )
                                    .addMarginLeft(10.h(context))
                                    .addMarginBottom(30.h(context))
                                    .addMarginTop(10.h(context)),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Themes.stroke,
                      ),
                    ],
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                          color: Colors.grey,
                          child: CachedNetworkImage(
                              imageUrl: ApiService.realUrl + posts[index].post!,
                              width: MediaQuery.of(context).size.width,
                              height: 250.h(context),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                    child: Text('Loading..'),
                                  ).addMarginTop(45.h(context)),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error)));
                    },
                    childCount: posts.length,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
