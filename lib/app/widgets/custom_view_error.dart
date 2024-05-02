// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../config/asset.dart';
import '../theme/colors.dart';
import '../theme/textstyles.dart';
import '../theme/size.dart';
import 'custom_button.dart';

class CustomErrorView extends StatelessWidget {
  CustomErrorView({
    super.key,
    this.title = 'Oops!',
    this.textButton = 'Coba Lagi',
    this.message =
        'Terjadi kesalahan saat memproses data. Cobalah beberapa saat lagi.',
    required this.onRefresh,
  });
  final String title, message, textButton;
  Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: maxHeight * 0.84,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: maxWidth / 1.5,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: interBold.copyWith(
                fontSize: maxHeight / 48,
                color: primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: maxHeight / 50,
          ),
          Image.asset(
            Asset.imgServerError,
            width: maxWidth / 3,
          ),
          SizedBox(
            height: maxHeight / 50,
          ),
          SizedBox(
            width: maxWidth / 1.8,
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: interMedium.copyWith(
                fontSize: maxHeight / 58,
                color: blackColor,
              ),
            ),
          ),
          SizedBox(height: maxHeight / 50),
          SizedBox(
            width: maxWidth / 2.8,
            child: CustomOutlineButton(
                text: textButton,
                action: onRefresh,
                height: maxHeight / 20,
                fontSize: maxHeight / 60,
                color: primaryColor),
          ),
        ],
      ),
    );
  }
}
