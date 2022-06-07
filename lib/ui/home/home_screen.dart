import 'dart:collection';

import 'package:insta_app/components/items/post_item.dart';
import 'package:insta_app/data/providers/post_provider.dart';
import 'package:insta_app/data/providers/token_provider.dart';
import 'package:insta_app/image_routing.dart';
import 'package:insta_app/services/api_interface.dart';
import 'package:insta_app/services/entities/post_response.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  ApiInterface? apiInterface;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      apiInterface = ApiInterface(context);
    });

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      value: 0,
      lowerBound: 0,
      upperBound: 45,
    );

    Future.delayed(const Duration(seconds: 2), () async {
      context.read<PostProvider>().getPosts(context, resetPage: true);
    });
  }

  void voidItem(int id) {
    Map<String, String> headers = HashMap();
    headers['Authorization'] = "Bearer " + context.read<TokenProvider>().token!;
    // apiInterface!.voidItem(
    //   id: id,
    //   header: headers,
    //   onUnhandleError: (e, response) {
    //     print(e);
    //   },
    //   onFinish: (response) {
    //     Navigator.pop(context);

    //     DefaultResponse defaultResponse =
    //         DefaultResponse.fromJson(jsonDecode(response.body));

    //     if (response.statusCode == 200) {
    //       setState(() {
    //         context.read<ItemProvider>().loading = true;
    //       });
    //       context.read<ItemProvider>().getListItem(context, resetPage: true);
    //     } else {
    //       Tools.showCustomDialog(
    //         context,
    //         dismissable: true,
    //         child: CustomAlertDialog(
    //           title: "Terjadi Kesalahan",
    //           message: defaultResponse.message!,
    //           onConfirm: () {
    //             Navigator.pop(context);
    //           },
    //         ),
    //       );
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    bool loading = context.watch<PostProvider>().loading;

    List<Post> posts = context.watch<PostProvider>().posts;
    RefreshController postRefreshController =
        context.watch<PostProvider>().postRefreshController;

    return Scaffold(
      backgroundColor: Themes.greyBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Insta App",
            textAlign: TextAlign.center,
            style: Themes(context).appbarTitleGradient,
          ).addMarginOnly(
            top: 48.h(context),
            left: 16.w(context),
            right: 8.w(context),
          ),
          Expanded(
            child: loading
                ? Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 23.h(context),
                      ),
                      child: const CircularProgressIndicator(),
                    ),
                  )
                : SmartRefresher(
                    controller: postRefreshController,
                    header: const ClassicHeader(
                      idleText: "Pull to refresh",
                      refreshingText: "Refresh",
                      releaseText: "Release",
                      completeText: "",
                    ),
                    footer: const ClassicFooter(
                      idleIcon: null,
                      idleText: "",
                      noDataText: "",
                      loadingText: "Loading",
                    ),
                    enablePullUp: posts.isNotEmpty,
                    onRefresh: () {
                      context
                          .read<PostProvider>()
                          .getPosts(context, resetPage: true);
                    },
                    onLoading: () {
                      if (context.read<PostProvider>().page <=
                          context.read<PostProvider>().maxPage) {
                        context.read<PostProvider>();
                        context.read<PostProvider>().getPosts(context);
                      } else {
                        postRefreshController.loadNoData();
                      }
                    },
                    child: posts.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImgRoute.assetsIconsIcAlert,
                                  width: 32.w(context),
                                ),
                                Text(
                                  "There is no data to display.",
                                  style: Themes(context).blackBold14,
                                ).addMarginTop(16.h(context)),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w(context),
                              vertical: 12.h(context),
                            ),
                            shrinkWrap: true,
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              Post post = posts[index];

                              return PostItem(
                                item: post,
                                onDelete: () {
                                  voidItem(posts[index].id!);
                                },
                                showOption: true,
                                onTap: () {
                                  // Tools.navigatePush(
                                  //   context,
                                  //   EditItemScreen(
                                  //     item: items[index],
                                  //   ),
                                  // );
                                },
                              ).addMarginTop(8.h(context));
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }
}
