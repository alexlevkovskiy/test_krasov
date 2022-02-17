import 'package:flutter/material.dart';
import 'package:test_krasov/colors.dart';
import 'package:test_krasov/const/resource.dart';
import 'package:test_krasov/gradient_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_krasov/list_item.dart';

import 'list_item_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          /* light theme settings */
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark, scaffoldBackgroundColor: Colors.black),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 40.w,
          ),
          _buildTitle(),
          _buildList(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        const GradientText(
          'Trending Today ',
          gradient: LinearGradient(colors: [
            cTitleGradientStart,
            cTitleGradientEnd,
          ]),
        ),
        SvgPicture.asset(R.ASSETS_ICONS_TAB_BAR_ICON_2_SVG),
      ],
    );
  }

  Widget _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: mockedData.length,
      itemBuilder: ((context, index) {
        return ListItem(mockedData[index]);
      }),
    );
  }

  List<ListItemData> mockedData = [
    ListItemData(R.ASSETS_IMAGES_LIST_ITEM1_PNG, 'Smash Stockpile', 10, 30, 15),
    ListItemData(R.ASSETS_IMAGES_LIST_ITEM2_PNG, 'FGC Rumble', 18, 18, 0),
    ListItemData(R.ASSETS_IMAGES_LIST_ITEM3_PNG, 'Valorant Volume', 21, 21, 21)
  ];
}
