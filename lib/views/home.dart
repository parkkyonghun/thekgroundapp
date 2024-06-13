import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:attendance/constants/assets.dart';
import 'package:attendance/core/authentication_manager.dart';
import 'package:attendance/utils/myTheme.dart';
import 'package:attendance/views/common_widgets/appBar.dart';
import 'package:attendance/views/common_widgets/profile.dart';
import 'package:attendance/views/homepage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';

import 'common_widgets/dropDownHomeMenu.dart';
import 'common_widgets/search_text_field.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver, AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final RxInt _currentIndex = 0.obs;
  // final ShoppingCartViewModel shoppingCart = Get.find<ShoppingCartViewModel>();
  late final PageController _pageController;

  late final List<CachedNetworkImageProvider> multiImageProvider;
  // TabController _tabController;
  MotionTabBarController? _motionTabBarController;
  AuthenticationManager authManager = Get.find();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final int initialTabIndex = Get.arguments ?? 0;
    _currentIndex.value = initialTabIndex;
    _pageController = PageController(initialPage: initialTabIndex);

    // _changeTab(initialTabIndex);
    // shoppingCart.getCartItemList();
    _motionTabBarController = MotionTabBarController(length: 4, vsync: this, initialIndex: initialTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: MyAppBar(
            leading: const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 8, top: 8),
              child: ProfileSection(),
            ),
            leadingWidth: MediaQuery.of(context).size.width * 2 / 2,
            // title: const Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: <Widget>[
            //     SizedBox(
            //       width: 12,
            //     )
            //   ],
            // ),
            actions: <Widget>[
              ThemeSwitcher(
                  clipper: const ThemeSwitcherCircleClipper(),
                  builder: (context) {
                    return InkResponse(
                      onTap: () => {
                        ThemeSwitcher.of(context).changeTheme(
                            theme: Get.isDarkMode
                                ? AppThemes.lightTheme1
                                : AppThemes.darkTheme2,
                            isReversed: Get.isDarkMode ? false : true)
                      },
                      child: CircleAvatar(
                        child: Image.asset(
                          Assets.imagesUser,
                          scale: 4,
                        ),
                      ),
                    );
                  }),
            ]),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            _currentIndex.value = index;
            // print("test motion : $index");
            _motionTabBarController!.index = index;
          },
          children: const [
             HomePage(),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    // shoppingCart.dispose();
    super.dispose();
    _motionTabBarController!.dispose();
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() {
     print("=======> ${_currentIndex.value}");
      return MotionTabBar(
        controller: _motionTabBarController, // Add this controller if you need to change your tab programmatically
        initialSelectedTab: "Home",
        useSafeArea: true, // default: true, apply safe area wrapper
        labels: const ["Home", "Profile", "Settings"],
        icons: const [Icons.home, Icons.people_alt, Icons.settings],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.blue[600],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue[900],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            _pageController.jumpToPage(value);
            _motionTabBarController!.index = value;
          });
        },
      );
    });
  }
}
