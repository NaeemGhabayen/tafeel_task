import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tafeel_task/utils/color_resources.dart';
import 'package:tafeel_task/utils/custom_themes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? caption;
  final VoidCallback? onPressedLeft;
  final Color? backgroundColor;
  final void Function()? onPressedRight;
  final bool isRightTitle;
  final bool isLeftTitle;
  final bool isRightIcon;
  final bool isLeftIcon;
  final String? rightIcons;
  final String? leftIcons;
  final String? rightTitle;
  final String? leftTitle;
  final Color? rightTitleColor;
  final Color? leftTitleColor;
  final Color? rightIconsColor;

  const CustomAppBar(
      {super.key,
      this.title,
      this.onPressedLeft,
      this.onPressedRight,
      this.rightIcons,
      this.caption,
      this.rightTitleColor,
      this.leftTitleColor,
      this.rightIconsColor,
      this.leftIcons,
      this.rightTitle,
      this.leftTitle,
      this.isLeftIcon = false,
      this.isRightIcon = false,
      this.isLeftTitle = false,
      this.isRightTitle = false,
      this.backgroundColor = background});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: 80,
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      actions: [
        Row(
          children: [
            isRightTitle
                ? GestureDetector(
                    onTap: onPressedRight,
                    child: Text(
                      rightTitle!,
                      textAlign: TextAlign.center,
                      style: bodyBlack.copyWith(color: rightTitleColor),
                    ),
                  )
                : const SizedBox(),
            isRightIcon &&

                    rightIconsColor != null
                ? IconButton(
                    icon:  Center(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(shape: BoxShape.circle , color: Color(0xFFEEF8F9)),
                        child:  Image.asset(
                          rightIcons!,
                          color: primary,
                        ),
                      ),
                    ),
                    onPressed: onPressedRight,
                  )
                : const SizedBox(
                    width: 12,
                  ),
          ],
        ),

      ],
      leading: Row(
        children: [
          isLeftIcon
              ? InkWell(
                  onTap: onPressedLeft,
                  child: leftIcons != null
                      ? SvgPicture.asset(leftIcons!)
                      : Center(
                        child: Container(
                          padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(shape: BoxShape.circle , color: Color(0xFFEEF8F9)),
                          child: const Icon(
                              Icons.arrow_back_ios_sharp,
                              size: 19,
                              color: primary,
                            ),
                        ),
                      ),
                )
              : const SizedBox(
                  width: 0,
                ),
          isLeftTitle
              ? InkWell(
                  onTap: onPressedLeft,
                  child: Text(
                     leftTitle!,
                    style: caption1.copyWith(color: leftTitleColor ),
                  ),
                )
              : const SizedBox()
        ],
      ),
      centerTitle: true,
      title: Column(
        children: [
          Text(
            title ?? '',
            style: calloutBoldBlack.copyWith(color: Color(0xFF393E40)),
          ),
          caption != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    caption!,
                    style: caption2Bold.copyWith(color: grey07),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
