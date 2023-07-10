import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
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
  final Widget? iconData;
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
      child: iconData != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color?>(foregroundColor),
                backgroundColor: MaterialStateProperty.all<Color?>(bgColor),
                elevation: MaterialStateProperty.all<double>(0.0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius!),
                  ),
                ),
              ),
              icon: iconData!,
              label: Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  letterSpacing: letterSpacing,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color?>(foregroundColor),
                backgroundColor: MaterialStateProperty.all<Color?>(bgColor),
                elevation: MaterialStateProperty.all<double>(0.0),
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

class PrimaryOutlinedButton extends StatelessWidget {
  const PrimaryOutlinedButton({
    super.key,
    this.onPressed,
    required this.title,
    this.bgColor,
    this.foregroundColor = Colors.black,
    this.textColor,
    this.iconData,
    this.isLoading,
    this.disabled,
    this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = 10,
    this.letterSpacing,
    this.buttonHeight,
    this.buttonWidth,
  });

  final String title;
  final Color? foregroundColor, bgColor, textColor;
  final Widget? iconData;
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
      child: iconData != null
          ? OutlinedButton.icon(
              onPressed: onPressed,
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color?>(foregroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius!),
                  ),
                ),
                side: MaterialStateProperty.all<BorderSide?>(
                  const BorderSide(color: Colors.black45),
                ),
              ),
              icon: iconData!,
              label: Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  letterSpacing: letterSpacing,
                ),
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color?>(foregroundColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius!),
                  ),
                ),
                side: MaterialStateProperty.all<BorderSide?>(
                  const BorderSide(color: Colors.black45),
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


// style: ButtonStyle(
//               foregroundColor: MaterialStateProperty.all<Color?>(Colors.black),
//               // backgroundColor: MaterialStateProperty.all<Color?>(bgColor),
//               elevation: MaterialStateProperty.all<double>(0.0),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               side: MaterialStateProperty.all<BorderSide?>(
//                 const BorderSide(
//                   color: Colors.black,
//                 ),
//               ),
//             ),