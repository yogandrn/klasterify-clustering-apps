import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/models/product.dart';
import '../theme/colors.dart';
import '../theme/size.dart';
import '../theme/textstyles.dart';
import '../utils/converter_helpers.dart';
import 'custom_dialog.dart';

class ItemProductGridCard extends StatelessWidget {
  const ItemProductGridCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showConfirmationDialog(
        title: product.name,
        message: 'Apakah Anda yakin ingin mengunjungi tautan produk ini?',
        imageUrl: product.imageUrl,
        cancelText: 'Batal',
        confirmText: 'Lanjutkan',
        onCancel: () => Get.back(),
        onConfirm: () {
          Get.back();
          launchUrl(
            Uri.parse(product.url),
            mode: LaunchMode.externalApplication,
          );
        },
      ),
      child: Container(
        width: maxWidth / 2,
        height: maxHeight / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radiusSmall),
          boxShadow: const [
            BoxShadow(
              color: silverColor,
              blurRadius: 9,
              offset: Offset(1, 3),
            ),
          ],
          color: whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: maxWidth / 2,
                height: maxHeight / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(radiusSmall),
                  ),
                  color: silverColor,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      product.imageUrl,
                      cacheKey: product.id,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: maxWidth / 2,
                height: maxHeight / 2,
                padding: EdgeInsets.symmetric(
                    vertical: maxHeight / 120, horizontal: maxWidth / 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(radiusSmall),
                  ),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: maxHeight < 700 ? 4 : 5,
                      overflow: TextOverflow.ellipsis,
                      style: interMedium.copyWith(
                          fontSize: maxHeight / 60,
                          color: blackColor,
                          height: 1.15),
                    ),
                    SizedBox(height: maxHeight / 135),
                    Text(
                      ConvertFormatter.formatRupiah(product.price),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: interSemiBold.copyWith(
                          fontSize: maxHeight / 56,
                          color: primaryColor,
                          height: 1),
                    ),
                    SizedBox(height: maxHeight / 135),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: -1,
                          child: Icon(
                            Icons.store,
                            size: maxHeight / 50,
                            color: secondaryColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ' ${product.seller}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: interMedium.copyWith(
                                fontSize: maxHeight / 63,
                                color: greyColor,
                                height: 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: maxHeight / 200),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: -1,
                          child: Icon(
                            Icons.location_on,
                            size: maxHeight / 54,
                            color: accentColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ' ${product.location}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: interMedium.copyWith(
                                fontSize: maxHeight / 64,
                                color: greyColor,
                                height: 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: maxHeight / 200),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: -1,
                          child: Icon(
                            Icons.star_rounded,
                            size: maxHeight / 52,
                            color: Colors.amber,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            ' ${product.ratingScore} | ${ConvertFormatter.formatNumberCount(product.sold)} Terjual',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: interMedium.copyWith(
                                fontSize: maxHeight / 64,
                                color: greyColor,
                                height: 1),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
