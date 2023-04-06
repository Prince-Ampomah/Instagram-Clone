import 'package:flutter/material.dart';
import 'package:instagram_clone/controller/profile_controller/edit_profile_controller.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_appbar.dart';

class EditNameView extends StatelessWidget {
  const EditNameView({super.key, this.fullname});

  final String? fullname;

  @override
  Widget build(BuildContext context) {
    EditProfileController.instance.fullnameController =
        TextEditingController(text: fullname ?? '');

    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'Name',
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
                await EditProfileController.instance.updateFullname();
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
          controller: EditProfileController.instance.fullnameController,
          textInputAction: TextInputAction.done,
          cursorColor: AppColors.blackColor,
          decoration: const InputDecoration(hintText: 'Name'),
          onSaved: (value) {
            EditProfileController.instance.fullnameController.text =
                value!.trim();
          },
        ),
      ),
    );
  }
}
