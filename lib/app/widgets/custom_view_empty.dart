// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../config/asset.dart';
import '../theme/colors.dart';
import '../theme/textstyles.dart';
import '../theme/size.dart';

class CustomEmptyView extends StatelessWidget {
  CustomEmptyView({
    super.key,
    this.title = 'Data Kosong',
    this.assetPath,
    required this.message,
  });
  final String title, message;
  String? assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: maxHeight * 0.84,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: maxWidth / 1.8,
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
            assetPath ?? Asset.imgEmptyData,
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
          SizedBox(
            height: maxHeight / 50,
          ),
        ],
      ),
    );
  }
}
