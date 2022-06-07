// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:insta_app/data/providers/page_provider.dart';
import 'package:insta_app/image_routing.dart';
import 'package:insta_app/services/api_interface.dart';
import 'package:insta_app/ui/home/home_screen.dart';
import 'package:insta_app/ui/profile/profile_screen.dart';
import 'package:insta_app/utils/responsive.dart';
import 'package:insta_app/utils/themes.dart';
import 'package:insta_app/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  ApiInterface? apiInterface;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      apiInterface = ApiInterface(context);
    });

    Tools.changeStatusbarIconColor(
      darkIcon: true,
      statusBarColor: Themes.black.withOpacity(0.1),
    );
  }

  @override
  Widget build(BuildContext context) {
    int pageIndex = context.watch<PageProvider>().pageIndex;
    PageController pageController =
        context.watch<PageProvider>().pageController;
    return Scaffold(
      backgroundColor: Themes.greyBg,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomeScreen(),
          // HomeScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 2,
            color: Themes.stroke,
          ),
          BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: pageIndex,
            onTap: (index) async {
              context.read<PageProvider>().toPage(index);
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            selectedLabelStyle: Themes(context).primaryBold12,
            unselectedLabelStyle: Themes(context)
                .primary12!
                .apply(color: Themes.black.withOpacity(0.5)),
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImgRoute.assetsIconsIcHouse,
                    width: 24.w(context),
                    height: 24.w(context),
                    color: pageIndex == 0
                        ? Themes.primary
                        : Themes.black.withOpacity(0.5),
                  ),
                  label: ""),
              // BottomNavigationBarItem(
              //     icon: SvgPicture.asset(
              //       ImgRoute.assetsIconsIcSearch,
              //       width: 24.w(context),
              //       height: 24.w(context),
              //       color: pageIndex == 1
              //           ? Themes.primary
              //           : Themes.black.withOpacity(0.5),
              //     ),
              //     label: ""),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImgRoute.assetsIconsIcProfile,
                    width: 24.w(context),
                    height: 24.w(context),
                    color: pageIndex == 2
                        ? Themes.primary
                        : Themes.black.withOpacity(0.5),
                  ),
                  label: ""),
            ],
          ),
        ],
      ),
    );
  }
}
