import 'package:flutter/material.dart';
import 'package:instagram_clone/core/constants/constants.dart';

import '../../../controller/profile_controller/edit_profile_controller.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/cus_appbar.dart';

class EditUsernameView extends StatelessWidget {
  const EditUsernameView({super.key, this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    EditProfileController.instance.usernameController =
        TextEditingController(text: username ?? '');

    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'Username',
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
                await EditProfileController.instance.updateUsername();
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
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: EditProfileController.instance.usernameController,
              textInputAction: TextInputAction.done,
              cursorColor: AppColors.blackColor,
              decoration: const InputDecoration(hintText: 'Username'),
              onSaved: (value) {
                EditProfileController.instance.usernameController.text =
                    value!.trim();
              },
            ),
            10.ph,
            Text(
              'You\'ll not be able to change your username back to $username for another 13 days.',
              style: const TextStyle(
                fontSize: 12.5,
                color: Colors.grey,
              ),
            ),
            5.ph,
            const Text(
              'Learn More',
              style: TextStyle(color: AppColors.buttonColor),
            ),
          ],
        ),
      ),
    );
  }
}
