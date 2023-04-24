import 'package:flutter/material.dart';

import '../../../controller/chat_controller/chat_controller.dart';
import '../../../core/widgets/cus_bottom_sheet.dart';
import '../../../core/widgets/cus_list_tile.dart';

class PickImagesOption extends StatelessWidget {
  const PickImagesOption({
    super.key,
    required this.chatController,
  });

  final ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetContainer(
      height: 0.2,
      child: Column(
        children: [
          CustomListTile(
            onTap: () async {
              Navigator.pop(context);
              await chatController.pickImageFromCamera();
            },
            minLeadingWidth: 20,
            leading: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.black,
            ),
            title: 'Camera',
            titleStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
          CustomListTile(
            onTap: () async {
              Navigator.pop(context);
              await chatController.pickImagesFromGallery();
            },
            minLeadingWidth: 20,
            leading: const Icon(
              Icons.image_outlined,
              color: Colors.black,
            ),
            title: 'Gallery',
            titleStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
