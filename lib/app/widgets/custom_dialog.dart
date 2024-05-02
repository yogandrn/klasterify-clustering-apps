import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:get/get.dart';

import '../config/asset.dart';
import '../theme/size.dart';
import '../theme/textstyles.dart';
import '../theme/colors.dart';
import 'custom_button.dart';

void showCustomSnackbar({required String message, bool isError = false}) {
  Get.showSnackbar(
    GetSnackBar(
      icon: isError
          ? Icon(
              Icons.error_outline_rounded,
              color: whiteColor,
              size: marginMedium * 2,
            )
          : null,
      messageText: Text(
        message,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style:
            interRegular.copyWith(fontSize: maxHeight / 58, color: whiteColor),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? errorColor : blackColor.withOpacity(0.7),
      boxShadows: [
        BoxShadow(
            color: blackColor.withOpacity(0.15),
            offset: const Offset(1, 8),
            blurRadius: 12),
      ],
      borderRadius: radiusMedium,
      duration: const Duration(milliseconds: 2000),
      animationDuration: const Duration(milliseconds: 400),
      margin: EdgeInsets.only(
        top: maxHeight / 12,
        right: maxWidth / 12,
        left: maxWidth / 12,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: marginSmall * 2,
        vertical: marginMedium,
      ),
    ),
  );
}

void showConfirmationDialog({
  required String title,
  required String message,
  required String cancelText,
  required String confirmText,
  required VoidCallback onCancel,
  required VoidCallback onConfirm,
  required String imageUrl,
}) {
  Get.dialog(
      // title: '',
      AlertDialog(
    scrollable: true,
    content: Container(
      width: maxWidth / 1.25,
      height: maxHeight / 2.2,
      padding: EdgeInsets.all(marginMedium * 2.5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusLarge), color: whiteColor),
      // padding: EdgeInsets.all(marginMedium),
      // color: whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: maxHeight < 700 ? 2 : 3,
            overflow: TextOverflow.ellipsis,
            style: interSemiBold.copyWith(
                height: 1.2, fontSize: maxHeight / 56, color: primaryColor),
          ),
          SizedBox(
            height: maxHeight / 7,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            message,
            maxLines: maxHeight < 700 ? 2 : 4,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: interRegular.copyWith(
                color: blackColor, fontSize: maxHeight / 56, height: 1.35),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: maxWidth / 3.6,
                child: CustomOutlineButton(
                  fontSize: maxHeight / 60,
                  text: cancelText,
                  action: onCancel,
                  height: maxHeight / 20 - 1,
                  color: errorColor,
                ),
              ),
              SizedBox(
                width: maxWidth / 3.4,
                child: CustomRoundedButton(
                    text: confirmText,
                    action: onConfirm,
                    height: maxHeight / 20,
                    color: primaryColor,
                    isShadow: false,
                    textColor: whiteColor,
                    fontSize: maxHeight / 60),
              ),
            ],
          )
        ],
      ),
    ),
    contentPadding: const EdgeInsets.all(0),
    // backgroundColor: whiteColor,
    elevation: radiusMedium,
    // actions: [
    //   Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       SizedBox(
    //         width: maxWidth / 3.6,
    //         child: CustomOutlineButton(
    //           fontSize: maxHeight / 60,
    //           text: cancelText,
    //           action: onCancel,
    //           height: maxHeight / 20 - 1,
    //           color: errorColor,
    //         ),
    //       ),
    //       SizedBox(
    //         width: maxWidth / 3.4,
    //         child: CustomRoundedButton(
    //             text: confirmText,
    //             action: onConfirm,
    //             height: maxHeight / 20,
    //             color: primaryColor,
    //             isShadow: false,
    //             textColor: whiteColor,
    //             fontSize: maxHeight / 60),
    //       ),
    //     ],
    //   )
    // ],
  ));
}

void showErrorConnection() {
  Get.dialog(AlertDialog(
    contentPadding: const EdgeInsets.all(0),
    scrollable: true,
    content: Container(
      width: maxWidth / 1.5,
      height: maxHeight <= 700 ? maxHeight / 2.5 : maxHeight / 3.0,
      padding: EdgeInsets.symmetric(
          vertical: marginMedium, horizontal: marginMedium * 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusLarge), color: whiteColor),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            Text(
              'Koneksi Terputus',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: interSemiBold.copyWith(
                  fontSize: maxHeight / 48, color: blackColor),
            ),
            SizedBox(height: marginSmall),
            Image.asset(
              Asset.imgDisconnected,
              width: maxWidth / 4.0,
            ),
            SizedBox(height: marginMedium),
            Text(
              'Perangkat tidak dapat terhubung ke jaringan internet',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: interMedium.copyWith(
                  fontSize: maxHeight / 58, color: blackColor),
            ),
          ],
        ),
      ),
    ),
  ));
}
