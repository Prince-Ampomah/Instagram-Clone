import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/cus_bottom_sheet.dart';

class EditPictureView extends StatelessWidget {
  const EditPictureView({
    super.key,
    this.onCameraTap,
    this.onGalleryTap,
    this.onRemovePictureTap,
  });

  final Function()? onCameraTap;
  final Function()? onGalleryTap;
  final Function()? onRemovePictureTap;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetContainer(
      height: 0.3,
      child: Expanded(
        child: ListView(
          shrinkWrap: true,
          children: [
            Material(
              child: ListTile(
                onTap: onCameraTap,
                leading: const Icon(
                  Icons.camera_alt,
                  size: 30,
                  color: AppColors.blackColor,
                ),
                title: const Text('Camera'),
              ),
            ),
            Material(
              child: ListTile(
                onTap: onGalleryTap,
                leading: const Icon(
                  Icons.image,
                  size: 30,
                  color: AppColors.blackColor,
                ),
                title: const Text('Gallery'),
              ),
            ),
            Material(
              child: ListTile(
                onTap: onRemovePictureTap,
                leading: const Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.red,
                ),
                title: const Text(
                  'Remove current picture',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
