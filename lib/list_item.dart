import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_krasov/const/resource.dart';
import 'package:test_krasov/list_item_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:palette_generator/palette_generator.dart';

class ListItem extends StatelessWidget {
  final ListItemData data;
  const ListItem(this.data, {Key? key}) : super(key: key);
  final double circleRadius = 64.0;
  @override
  Widget build(BuildContext context) {
    return _buildCard(context);
  }

  Widget _buildCard(BuildContext context) {
    return FutureBuilder<PaletteGenerator>(
        future: _updatePaletteGenerator(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                Color mainColor = snapshot.data!.dominantColor!.color;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.w),
                  ),
                  shadowColor: Colors.transparent,
                  color: Colors.white.withAlpha(50),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        32.w,
                      ),
                      gradient: RadialGradient(
                          colors: [mainColor, Colors.transparent], radius: 1),
                    ),
                    //  key: UniqueKey(),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: circleRadius / 2,
                                ),
                                child: Image.asset(
                                  data.imagePath,
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              _buildBlurPlayButton(),
                            ],
                          ),
                          _buildBottomData(),
                        ],
                      ),
                    ),
                  ),
                );
              }
          }
        });
  }

  Widget _buildBottomData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
        ),
        SizedBox(
          height: 2.w,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '+${data.newVideos} New Videos',
                style: TextStyle(
                    color: _getTextColor(),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp),
              ),
            ),
            SvgPicture.asset(
              R.ASSETS_ICONS_WATCH_ICON_SVG,
              height: 12.w,
            ),
            Text(
              '${data.viwed}/${data.totalView}',
              style: TextStyle(
                  color: _viewCounterColor(),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp),
              maxLines: 1,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: LinearProgressIndicator(
            color: const Color(0xffF2BC3D),
            value: calculateValue(),
          ),
        )
      ],
    );
  }

  Widget _buildBlurPlayButton() {
    return Container(
      margin: EdgeInsets.only(right: 30.w),
      width: circleRadius,
      height: circleRadius,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(circleRadius),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  width: 90,
                  height: 45,
                ),
              ),
            ),
            Center(
                child: RawMaterialButton(
              onPressed: () {},
              elevation: 2.0,
              fillColor: Colors.white.withOpacity(0.15),
              child: const Icon(
                Icons.play_arrow,
                size: 35.0,
              ),
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
            )),
          ],
        ),
      ),
    );
  }

  Future<PaletteGenerator> _updatePaletteGenerator() async {
    return await PaletteGenerator.fromImageProvider(
      Image.asset(data.imagePath).image,
    );
  }

  double calculateValue() {
    if (data.viwed == 0) {
      return 0;
    }
    return data.viwed / data.totalView;
  }

  Color _getTextColor() {
    if (data.viwed == data.totalView) {
      return const Color(0xff645F6D);
    }
    return const Color(0xffF2BC3D);
  }

  Color _viewCounterColor() {
    if (data.viwed > 0) {
      return const Color(0xff645F6D);
    }
    return const Color(0xffF2BC3D);
  }
}
