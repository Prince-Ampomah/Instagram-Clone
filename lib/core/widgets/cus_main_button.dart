import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_circular_progressbar.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    this.onPressed,
    required this.title,
    this.bgColor,
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
  final Color? foregroundColor, bgColor, textColor;
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
                    MaterialStateProperty.all<Color?>(foregroundColor),
                backgroundColor: MaterialStateProperty.all<Color?>(bgColor),
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
                        const SizedBox(
                          height: 18,
                          width: 18,
                          child: Center(
                            child: CustomCircularProgressBar(
                              bgColor: Colors.white,
                              valueColor: Colors.blue,
                            ),
                          ),
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
                    MaterialStateProperty.all<Color?>(foregroundColor),
                backgroundColor: MaterialStateProperty.all<Color?>(bgColor),
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
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: Center(
                        child: CustomCircularProgressBar(
                          bgColor: Colors.white,
                          valueColor: Colors.blue,
                        ),
                      ),
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
            ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    required this.title,
    this.bgColor,
    this.foregroundColor = Colors.white,
    this.textColor,
    this.iconData,
    this.isLoading,
    this.disabled,
    this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = 5,
    this.letterSpacing,
    this.buttonHeight,
    this.buttonWidth,
  });

  final String title;
  final Color? foregroundColor, bgColor, textColor;
  final IconData? iconData;
  final bool? isLoading, disabled;
  final double? fontSize,
      letterSpacing,
      borderRadius,
      buttonHeight,
      buttonWidth;
  final FontWeight? fontWeight;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color?>(foregroundColor),
          backgroundColor: MaterialStateProperty.all<Color?>(bgColor),
          elevation: MaterialStateProperty.all<double>(0.0),

          // padding: MaterialStateProperty.all(
          //   const EdgeInsets.symmetric(
          //     horizontal: 14,
          //     vertical: 14,
          //   ),
          // ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!),
            ),
          ),
        ),
        child: Text(
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
