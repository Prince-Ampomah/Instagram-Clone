import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/cus_form_field.dart';
import '../../../core/widgets/cus_main_button.dart';
import 'sign_up_create_username_view.dart';

class CreateNameAndPasswordView extends StatelessWidget {
  const CreateNameAndPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 120),
                Text(
                  'NAME AND PASSWORD',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 50),
                CustomFormField(
                  hintText: 'Full name',
                  filled: true,
                  fillColor: AppColors.textFieldColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  hintText: 'Password',
                  filled: true,
                  fillColor: AppColors.textFieldColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.visibility_off,
                      size: 20,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
                CheckboxListTile(
                  title: Text(
                    'Remember password',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  value: true,
                  onChanged: (isChecked) {},
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.buttonColor,
                ),
                const SizedBox(height: 20),
                MainButton(
                  onPressed: () {
                    Get.to(const CreateUsernameView());
                  },
                  title: 'Continue',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
