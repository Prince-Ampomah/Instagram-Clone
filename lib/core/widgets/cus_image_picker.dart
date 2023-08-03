import 'package:flutter/material.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';
import 'package:instagram_clone/core/widgets/cus.bottom.sheet.icons.dart';
import 'package:instagram_clone/core/widgets/cus_cached_image.dart';

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker({
    Key? key,
    this.imagePath,
    this.cameraOnTap,
    this.galleryOnTap,
    this.placeHolderText,
    this.placeHolder,
    this.boxShape = BoxShape.rectangle,
    this.width,
    this.height = 150,
    this.boxBorder,
    this.borderRadius,
  }) : super(key: key);

  final String? imagePath;
  final String? placeHolderText;
  final Widget? placeHolder;
  final double? width;
  final double? height;
  final BoxShape? boxShape;
  final BoxBorder? boxBorder;
  final BorderRadius? borderRadius;
  final Function()? cameraOnTap, galleryOnTap;

  @override
  Widget build(BuildContext context) {
    //get the device orientation [portrait or landscape]
    Orientation orientation = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => buildBottomItems(context, height, orientation),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: boxShape!,
          border: boxBorder ?? Border.all(width: 1.0),
          borderRadius: borderRadius ?? BorderRadius.circular(0),
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          child: imagePath != null
              ? CustomCachedImage(imageUrl: imagePath!, fit: BoxFit.cover)
              : Stack(
                  children: [
                    if (placeHolder != null) placeHolder!,
                    Center(
                      child: Text(
                        placeHolderText ?? '',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  buildBottomItems(context, height, Orientation orientation) {
    double height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height:
          orientation == Orientation.portrait ? height * 0.23 : height * 0.50,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 0.0),
              child: const Text('Upload photo',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w200,
                  )),
            ),
            Row(
              children: [
                CusBottomSheetIcons(
                    onTap: cameraOnTap,
                    icons: Icons.camera_alt,
                    color: AppColors.blackColor,
                    text: 'Camera',
                    textSize: 16.0),
                CusBottomSheetIcons(
                    onTap: galleryOnTap,
                    icons: Icons.image,
                    color: AppColors.blackColor,
                    text: 'Gallery',
                    textSize: 16.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}
