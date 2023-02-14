import 'package:flutter/material.dart';

import '../constants/constants.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.bgColor = Colors.blue,
    this.foregroundColor = Colors.white,
    this.textColor,
    this.iconData,
    this.isLoading,
    this.disabled,
    this.fontSize,
    this.isLoadingText = 'Please Wait...',
    this.fontWeight = FontWeight.w600,
    this.borderRadius = 5,
    this.letterSpacing,
  }) : super(key: key);

  final String title, isLoadingText;
  final Color foregroundColor;
  final Color? bgColor, textColor;
  final IconData? iconData;
  final bool? isLoading, disabled;
  final double? fontSize, letterSpacing, borderRadius;
  final FontWeight? fontWeight;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: iconData == null
          ? ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(foregroundColor),
                backgroundColor: MaterialStateProperty.all<Color>(bgColor!),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius!),
                  ),
                ),
              ),
              child: isLoading != null && isLoading!
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // const SpinKitFadingCircle(
                        //   color: Colors.white,
                        //   size: 20.0,
                        // ),
                        SizedBox(
                          height: 20,
                          child: Image.asset(Const.loadingGif),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          isLoadingText,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: fontWeight,
                            fontSize: fontSize,
                            letterSpacing: letterSpacing,
                          ),
                        )
                      ],
                    )
                  : Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                        letterSpacing: letterSpacing,
                      ),
                    ),
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(foregroundColor),
                backgroundColor: MaterialStateProperty.all<Color>(bgColor!),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius!),
                  ),
                ),
              ),
              icon: Icon(iconData),
              label: isLoading != null && isLoading!
                  ? SizedBox(
                      height: 20,
                      child: Image.asset(Const.loadingGif),
                    )
                  // const SpinKitFadingCircle(
                  //     color: Colors.white,
                  //     size: 20.0,
                  //   )
                  : Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                        letterSpacing: letterSpacing,
                      ),
                    ),
            ),
    );
  }
}
