import 'package:flutter/material.dart';

class CusSimpleDialog extends StatelessWidget {
  const CusSimpleDialog({this.title, this.children, Key? key})
      : super(key: key);
  final Widget? title;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      insetPadding: const EdgeInsets.all(20),
      title: title,
      children: children,
    );
  }
}

class CusDefaultAlertDialog extends StatelessWidget {
  const CusDefaultAlertDialog({
    Key? key,
    this.title,
    this.content,
    this.onPressed1,
    this.onPressed2,
    this.text1 = 'No',
    this.text2 = 'Yes',
    this.backgroundColor1,
    this.backgroundColor2,
    this.backgroundColor = Colors.white,
    this.textColor1,
    this.textColor2,
    this.isLoading = false,
    this.actionBorderRadius = 5,
    this.actionsPadding,
    this.titleTextStyle,
    this.fontWeight1,
    this.fontWeight2,
  }) : super(key: key);

  final Widget? title, content;
  final String text1, text2;
  final void Function()? onPressed1, onPressed2;
  final Color? backgroundColor,
      backgroundColor1,
      backgroundColor2,
      textColor1,
      textColor2;
  final bool isLoading;
  final double? actionBorderRadius;
  final EdgeInsetsGeometry? actionsPadding;
  final TextStyle? titleTextStyle;
  final FontWeight? fontWeight1, fontWeight2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: title,
      titleTextStyle: titleTextStyle,
      content: content,
      actions: isLoading
          ? null
          : [
              TextButton(
                onPressed: onPressed1,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(backgroundColor1),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(actionBorderRadius!),
                    ),
                  ),
                ),
                child: Text(
                  text1,
                  style: TextStyle(
                    color: textColor1,
                    fontSize: 16.0,
                    fontWeight: fontWeight1,
                  ),
                ),
              ),
              TextButton(
                onPressed: onPressed2,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(backgroundColor2),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(actionBorderRadius!),
                    ),
                  ),
                ),
                child: Text(
                  text2,
                  style: TextStyle(
                    color: textColor2,
                    fontSize: 16.0,
                    fontWeight: fontWeight1,
                  ),
                ),
              ),
            ],
      actionsPadding: actionsPadding,
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    this.descriptions,
    this.actionsButtons,
    this.dialogIcon,
  }) : super(key: key);

  final String? title, descriptions;
  final Widget? dialogIcon;
  final List<Widget>? actionsButtons;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      insetAnimationCurve: Curves.easeIn,
      insetAnimationDuration: const Duration(milliseconds: 3000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, size),
    );
  }

  contentBox(context, Size size) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: Constants.padding,
            top: Constants.avatarRadius + Constants.padding,
            right: Constants.padding,
            bottom: Constants.padding,
          ),
          // constraints: BoxConstraints(
          //   maxWidth: isMobile(context) ? double.infinity : size.width * 0.3,
          // ),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: const [
              BoxShadow(
                // color: Colors.grey[700],
                offset: Offset(0, 3),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  '$title',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "$descriptions",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: actionsButtons ?? [],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Constants.avatarRadius,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    Constants.avatarRadius,
                  ),
                ),
                child: dialogIcon ?? Container(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 15;
  static const double avatarRadius = 45;
}
