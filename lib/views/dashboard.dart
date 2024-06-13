import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/assets.dart';
import '../utils/myTheme.dart';
import 'common_widgets/appBar.dart';
import 'common_widgets/carousel.dart';
import 'package:get/get.dart';
import 'common_widgets/categories_view.dart';
import 'common_widgets/dropDownHomeMenu.dart';
import 'common_widgets/horizontal_product_list.dart';
import 'common_widgets/see_all_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AutomaticKeepAliveClientMixin {
  // final ProductViewModel productViewModel = Get.find<ProductViewModel>();
  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> initState() async => super.initState();

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyAppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
            child: DropDownMenu(),
          ),
          leadingWidth: MediaQuery.of(context).size.width * 2 / 4,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                width: 12,
              ),
              const Icon(
                Icons.delivery_dining,
                color: Colors.redAccent,
              ),
              const SizedBox(
                width: 4,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Free delivery',
                    style: TextStyle(
                        color: Get.theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: 0),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    '2000da +',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CircleAvatar(
                        child: Image.asset(
                          Assets.imagesUser,
                          scale: 4,
                        ),
                      ),
                    ),
                  );
                }),
          ]),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  onTap: () => Get.toNamed('/search'),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Color.fromARGB(255, 219, 219, 219)),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      hintText: "What are u looking for ?",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Get.theme.colorScheme.primary,
                          fontWeight: FontWeight.w500),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      prefixIcon: const Icon(
                        CupertinoIcons.search,
                        color: Color(0xff2382AA),
                      ),
                      suffixIcon: InkWell(
                        onTap: () => Get.toNamed("/ArExperience"),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: Icon(
                            CupertinoIcons.camera,
                            color: Color.fromARGB(255, 193, 193, 193),
                          ),
                        ),
                      )))),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Carousel()),
          Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SeeAllView(
                    context: context,
                    name: "Categories 🛍️",
                    onTapAction: () => Get.toNamed("/dashboard", arguments: 1)),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CategoriesView(
                            imagePath: Assets.imagesFish,
                            catName: "Seafood",
                            context: context),
                        CategoriesView(
                            imagePath: Assets.imagesFalafel,
                            catName: "Vegetables",
                            context: context),
                        CategoriesView(
                            imagePath: Assets.imagesBanana,
                            catName: "Fruits",
                            context: context),
                        CategoriesView(
                            imagePath: Assets.imagesIceCream,
                            catName: "Snacks",
                            context: context),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        CategoriesView(
                            imagePath: Assets.imagesDish,
                            catName: "Canned food",
                            context: context),
                        CategoriesView(
                            imagePath: Assets.imagesRice,
                            catName: "Pasta, Rice",
                            context: context),
                        CategoriesView(
                            imagePath: Assets.imagesSavon,
                            catName: "Home Supplie",
                            context: context),
                        CategoriesView(
                            imagePath: Assets.imagesMakeup,
                            catName: "Woman care",
                            context: context),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SeeAllView(
                    context: context,
                    name: "Best deals 🔥",
                    onTapAction: () => Get.toNamed("/vegetables")),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: SizedBox(
                    height: 210,
                    //padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: HorizontalProductList(
                      page: 1,
                      isSecondList: false,
                    )),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
