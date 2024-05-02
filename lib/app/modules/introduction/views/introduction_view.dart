import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';

import '../../../config/asset.dart';
import '../../../theme/colors.dart';
import '../../../theme/textstyles.dart';
import '../../../theme/size.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),
      renderSkipBtn: renderSkipBtn(),
      renderNextBtn: renderNextBtn(),

      renderDoneBtn: renderDoneBtn(),
      onDonePress: controller.onDonePress,

      indicatorConfig: IndicatorConfig(
        sizeIndicator: marginLarge / 2,
        indicatorWidget: Container(
          width: marginLarge / 2,
          height: marginLarge / 2,
          margin: EdgeInsets.only(bottom: maxHeight / 15),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: greyColor,
          ),
        ),
        activeIndicatorWidget: Container(
          width: marginMedium,
          height: marginMedium,
          margin: EdgeInsets.only(bottom: maxHeight / 15),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
          ),
        ),
        typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
      ),

      // Custom tabs
      listCustomTabs: generateListCustomTabs(),
      backgroundColorAllTabs: whiteColor,
      refFuncGoToTab: (refFunc) {
        controller.goToTab = refFunc;
      },

      // Behavior
      scrollPhysics: const BouncingScrollPhysics(),
      onTabChangeCompleted: controller.onTabChangeCompleted,
    );
  }

  Widget renderNextBtn() {
    return Text(
      'Lanjutkan',
      style: interSemiBold.copyWith(
        fontSize: maxHeight / 58,
        color: primaryColor,
      ),
    );
  }

  Widget renderDoneBtn() {
    return Text(
      'Selesai',
      style: interSemiBold.copyWith(
        fontSize: maxHeight / 56,
        color: primaryColor,
      ),
    );
  }

  Widget renderSkipBtn() {
    return Text(
      'Lewati',
      style: interRegular.copyWith(
        fontSize: maxHeight / 58,
        color: greyColor,
      ),
    );
  }

  Widget _buildScreenOnboardingPrimary({
    required String title,
    required String desc,
    required String assetName,
  }) {
    return Container(
      padding: EdgeInsets.only(top: marginLarge),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: maxHeight / 12.8,
          ),
          Container(
            margin: EdgeInsets.all(marginLarge),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: interBold.copyWith(
                fontSize: (maxHeight >= 700) ? maxHeight / 40 : maxHeight / 35,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: maxHeight / 24,
          ),
          Image.asset(
            assetName,
            filterQuality: FilterQuality.high,
            height: (maxHeight >= 700) ? maxHeight / 4 : maxHeight / 3.2,
          ),
          SizedBox(
            height: maxHeight / 24,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: marginMedium,
              horizontal: marginLarge * 2,
            ),
            child: Text(
              desc,
              maxLines: 5,
              textAlign: TextAlign.center,
              style: interRegular.copyWith(
                fontSize: maxHeight / 55,
                color: greyColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> generateListCustomTabs() {
    return [
      _buildScreenOnboardingPrimary(
        title: controller.title1,
        desc: controller.desc1,
        assetName: Asset.imgIntroduction1,
      ),
      _buildScreenOnboardingPrimary(
        title: controller.title2,
        desc: controller.desc2,
        assetName: Asset.imgIntroduction2,
      ),
      _buildScreenOnboardingPrimary(
        title: controller.title3,
        desc: controller.desc3,
        assetName: Asset.imgIntroduction3,
      ),
    ];
  }
}
