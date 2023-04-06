import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/helper_functions.dart';

import '../../../controller/auth_controller/auth_controller.dart';
import '../../../controller/auth_controller/password_visibility_controller.dart';
import '../../../core/theme/theme.dart';
import '../../../core/utils/form_validator.dart';
import '../../../core/widgets/cus_form_field.dart';
import '../../../core/widgets/cus_main_button.dart';
import 'sign_up_create_username_view.dart';

class CreateNameAndPasswordView extends StatefulWidget {
  const CreateNameAndPasswordView({super.key});

  @override
  State<CreateNameAndPasswordView> createState() =>
      _CreateNameAndPasswordViewState();
}

class _CreateNameAndPasswordViewState extends State<CreateNameAndPasswordView> {
  final passwordController = Get.put(PasswordVisibilityController());

  final formKey = GlobalKey<FormState>();

  late String password;

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
                    'NAME AND PASSWORD',
                    style: AppTheme.textStyle(context).titleSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 50),
                  CustomFormField(
                    hintText: 'Full name',
                    filled: true,
                    fillColor: AppColors.textFieldColor,
                    validator: FormValidator.emptyFieldValidator,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onSaved: (value) {
                      AuthController.instance.userModel.fullname =
                          value!.trim();
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  GetBuilder<PasswordVisibilityController>(
                    builder: (passwordController) {
                      return CustomFormField(
                        hintText: 'Password',
                        filled: true,
                        isPasswordField:
                            passwordController.showPassword ? true : false,
                        fillColor: AppColors.textFieldColor,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.none,
                        validator: FormValidator.emptyFieldValidator,
                        onSaved: (value) {
                          password = value!.trim();
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () => passwordController.togglePassword(),
                          icon: Icon(
                            passwordController.showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20,
                            color: AppColors.greyColor,
                          ),
                        ),
                      );
                    },
                  ),
                  CheckboxListTile(
                    title: Text(
                      'Remember password',
                      style: AppTheme.textStyle(context).labelMedium,
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
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        Get.to(() => CreateUsernameView(password: password));
                      } else {
                        showToast(msg: 'Fill in all required field');
                      }
                    },
                    title: 'Continue',
                    bgColor: AppColors.buttonColor,
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
