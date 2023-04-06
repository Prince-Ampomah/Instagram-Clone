import 'package:flutter/material.dart';

import '../../../controller/profile_controller/edit_profile_controller.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_appbar.dart';

class EditBioView extends StatelessWidget {
  const EditBioView({super.key, this.bio});
  final String? bio;
  @override
  Widget build(BuildContext context) {
    EditProfileController.instance.bioController =
        TextEditingController(text: bio ?? '');

    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'Bio',
        titleStyle: const TextStyle(fontWeight: FontWeight.bold),
        leadingIcon: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.clear, size: 30),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                await EditProfileController.instance.updateBio();
              },
              icon: const Icon(
                Icons.check,
                size: 30,
                color: AppColors.buttonColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: TextFormField(
          controller: EditProfileController.instance.bioController,
          maxLines: 20,
          minLines: 1,
          textInputAction: TextInputAction.newline,
          cursorColor: AppColors.blackColor,
          decoration: const InputDecoration(hintText: 'Bio'),
          onSaved: (value) {
            EditProfileController.instance.bioController.text = value!.trim();
          },
        ),
      ),
    );
  }
}
