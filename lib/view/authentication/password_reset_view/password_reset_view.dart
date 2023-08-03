import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';
import 'package:instagram_clone/core/utils/form_validator.dart';
import '../../../controller/auth_controller/auth_controller.dart';
import '../../../core/theme/theme.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/widgets/cus_appbar.dart';
import '../../../core/widgets/cus_form_field.dart';
import '../../../core/widgets/cus_main_button.dart';
import '../../../core/widgets/cus_rich_text.dart';

class PasswordResetView extends StatefulWidget {
  const PasswordResetView({super.key});

  @override
  State<PasswordResetView> createState() => _PasswordResetViewState();
}

class _PasswordResetViewState extends State<PasswordResetView> {
  String? email;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: CustomAppBar(
        implyLeading: true,
        title: 'Login help',
        titleStyle: AppTheme.textStyle(context)
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                const SizedBox(height: 50),
                CustomRichText(
                  textAlign: TextAlign.center,
                  text1: 'Find your account\n\n',
                  text2: 'Enter your email linked to your account',
                  text1Style: AppTheme.textStyle(context).titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                  text2Style: AppTheme.textStyle(context)
                      .labelMedium!
                      .copyWith(color: AppColors.greyColor),
                ),
                const SizedBox(height: 30),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomFormField(
                        hintText: 'Email',
                        filled: true,
                        fillColor: AppColors.textFieldColor,
                        autofillHints: const [AutofillHints.email],
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.none,
                        validator: FormValidator.validateEmail,
                        onSaved: (value) {
                          email = value!.trim();

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      GetX<AuthController>(
                        builder: (controller) {
                          return MainButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : resetPassword,
                            title: 'Reset password',
                            isLoading: controller.isLoading.value,
                            bgColor: controller.isLoading.value
                                ? null
                                : AppColors.buttonColor,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Divider()),
                    const SizedBox(width: 10),
                    Text('OR', style: AppTheme.textStyle(context).labelMedium),
                    const SizedBox(width: 10),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),

                // facebook widget
                MainButton(
                  onPressed: () {},
                  iconData: FontAwesomeIcons.facebook,
                  title: 'Contiue as Prince Ampomah',
                  bgColor: Colors.blue.shade700,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetPassword() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      await AuthController.instance.resetUserPassword(email!);
    } else {
      showToast(msg: 'Email is required');
    }
  }
}
