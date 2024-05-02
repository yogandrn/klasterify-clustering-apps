import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/size.dart';
import '../theme/textstyles.dart';

class CustomRoundedButton extends StatelessWidget {
  final String text;
  final Function()? action;
  final Color color, textColor;
  final double height, fontSize, borderRadius;
  final bool isShadow;
  const CustomRoundedButton({
    Key? key,
    required this.text,
    required this.action,
    this.borderRadius = 16,
    required this.height,
    required this.color,
    required this.isShadow,
    required this.textColor,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: maxWidth,
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusLarge),
            boxShadow: isShadow
                ? [
                    BoxShadow(
                        color: primaryColor.withOpacity(0.25),
                        offset: const Offset(2, 8),
                        blurRadius: marginMedium),
                  ]
                : []),
        child: Center(
          child: Text(
            text,
            style: interSemiBold.copyWith(fontSize: fontSize, color: textColor),
          ),
        ),
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  final String text;
  final void Function()? action;
  final Color color, textColor;
  final double height, fontSize, borderRadius;
  final bool isShadow;
  final Widget icon;
  const CustomButtonWithIcon({
    Key? key,
    required this.text,
    required this.action,
    required this.icon,
    required this.textColor,
    required this.height,
    required this.color,
    required this.isShadow,
    required this.fontSize,
    this.borderRadius = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: maxWidth,
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusLarge),
            boxShadow: isShadow
                ? [
                    BoxShadow(
                        color: blackColor.withOpacity(0.2),
                        offset: Offset(2, 8),
                        blurRadius: marginMedium),
                  ]
                : [const BoxShadow()]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: marginMedium),
            Text(
              text,
              style: interMedium.copyWith(fontSize: fontSize, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final void Function()? action;
  final Color color;
  final double height, fontSize, borderWidth, borderRadius;
  const CustomOutlineButton({
    Key? key,
    required this.text,
    required this.action,
    this.fontSize = 16,
    this.borderWidth = 2,
    this.borderRadius = 16,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: maxWidth,
        height: height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radiusLarge),
          border: Border.all(color: color, width: borderWidth),
        ),
        child: Center(
          child: Text(
            text,
            style: interSemiBold.copyWith(fontSize: fontSize, color: color),
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final void Function() action;
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.action,
    required this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.fontSize = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      splashColor: primaryColor.withOpacity(0.1),
      hoverColor: primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(radiusSmall),
      child: Padding(
        padding: padding,
        child: Center(
          child: Text(
            text,
            style: interSemiBold.copyWith(
                fontSize: fontSize, color: color, height: 1.05),
          ),
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Function() action;
  final IconData icon;
  final double size;
  final Color color;
  final List<Shadow>? shadows;
  const CustomIconButton({
    super.key,
    required this.action,
    required this.icon,
    this.size = 24.0,
    this.color = whiteColor,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Center(
        child: Icon(
          icon,
          size: size,
          color: color,
          shadows: shadows,
        ),
      ),
    );
  }
}
