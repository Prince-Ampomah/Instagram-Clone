import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/controller/auth_controller/auth_controller.dart';
import 'package:instagram_clone/core/utils/form_validator.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/view/authentication/email_verification/email_verification_view.dart';

import '../../../core/constants/constants.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/cus_form_field.dart';
import '../../../core/widgets/cus_main_button.dart';

class CreateUsernameView extends StatefulWidget {
  const CreateUsernameView({super.key, required this.password});

  final String password;

  @override
  State<CreateUsernameView> createState() => _CreateUsernameViewState();
}

class _CreateUsernameViewState extends State<CreateUsernameView> {
  final formKey = GlobalKey<FormState>();
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  Text(
                    'CREATE USERNAME',
                    style: AppTheme.textStyle(context).titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add a username. You can change this at any time.',
                    style: AppTheme.textStyle(context).labelMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.greyColor,
                        ),
                  ),
                  const SizedBox(height: 50),
                  CustomFormField(
                    hintText: 'Username',
                    filled: true,
                    fillColor: AppColors.textFieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    validator: FormValidator.emptyFieldValidator,
                    onSaved: (value) {
                      AuthController.instance.userModel.userHandle =
                          value!.trim();
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  MainButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        // register user
                        // Get.to(() => const CreateUsernameView());

                        await AuthController.instance.signUserUp(
                          AuthController.instance.userModel.email!,
                          widget.password,
                        );

                        Get.off(() => const EmailVerificationView());
                      } else {
                        showToast(msg: 'Username is required');
                      }
                    },
                    title: 'Continue',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
