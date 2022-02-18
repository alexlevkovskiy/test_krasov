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

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
            canvasColor: Colors.black,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black),
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
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(R.ASSETS_IMAGES_TAB_BAR_ICON_1_PNG),
            label: 'Hot',
          ),
          BottomNavigationBarItem(
            label: '',
            icon: SvgPicture.asset(R.ASSETS_ICONS_TAB_BAR_ICON_2_SVG),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: SvgPicture.asset(R.ASSETS_ICONS_TAB_BAR_ICON_3_SVG),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: SvgPicture.asset(R.ASSETS_ICONS_TAB_BAR_ICON_4_SVG),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Image.asset(R.ASSETS_IMAGES_TAB_BAR_ICON_5_PNG),
          )
        ],
      ),
    );
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
          _buildFooter()
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Image.asset(R.ASSETS_IMAGES_VERIFICATION_ICON_PNG),
        Text('Check back soon for new clips and creator content.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.sp)),
        Padding(
          padding: EdgeInsets.only(top: 8.w, bottom: 40.w),
          child: Text('In the meantime join our discord.',
              style: TextStyle(
                  color: const Color(0xffA19DAA),
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp)),
        ),
        _buildDiscordButton()
      ],
    );
  }

  Widget _buildDiscordButton() {
    return DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xffbf9000), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(color: Colors.yellow.withAlpha(120), width: 0.5.w),
          borderRadius: BorderRadius.circular(24.w),
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              onSurface: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                top: 18,
                bottom: 18,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    R.ASSETS_IMAGES_DISCORD_PNG,
                    width: 22.w,
                  ),
                  SizedBox(width: 8.w),
                  const Text("Join Metaview Discord"),
                ],
              ),
            )));
  }

  Widget _buildTitle() {
    return Row(
      children: [
        GradientText(
          'Trending Today 🔥',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 34.sp,
          ),
          gradient: const LinearGradient(colors: [
            cTitleGradientStart,
            cTitleGradientEnd,
          ]),
        ),
      ],
    );
  }

  Widget _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
