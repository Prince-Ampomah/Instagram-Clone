import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';

import '../../../controller/auth_controller/auth_controller.dart';
import '../../../controller/auth_controller/password_visibility_controller.dart';
import '../../../core/constants/constants.dart';
import '../../../core/theme/theme.dart';
import '../../../core/utils/form_validator.dart';
import '../../../core/widgets/cus_form_field.dart';
import '../../../core/widgets/cus_main_button.dart';
import '../../../core/widgets/cus_rich_text.dart';
import '../password_reset_view/password_reset_view.dart';
import '../sign_up_view/sign_up_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String? email, password;

  final formKey = GlobalKey<FormState>();

  final passwordController = Get.put(PasswordVisibilityController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('English (United States)'),
                    Icon(
                      Icons.expand_more_outlined,
                      size: 20,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // logo
                        SizedBox(
                          height: 60,
                          child: Image.asset(
                            Const.instragramLogoIcon,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // text fields
                        CustomFormField(
                          hintText: 'Email',
                          filled: true,
                          fillColor: AppColors.textFieldColor,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.none,
                          validator: FormValidator.validateEmail,
                          onSaved: (value) {
                            email = value!.trim();
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        GetBuilder<PasswordVisibilityController>(
                          builder: (passwordController) {
                            return CustomFormField(
                              hintText: 'Password',
                              filled: true,
                              isPasswordField: passwordController.showPassword
                                  ? true
                                  : false,
                              fillColor: AppColors.textFieldColor,
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.none,
                              validator: FormValidator.emptyFieldValidator,
                              onSaved: (value) {
                                password = value!.trim();
                                return null;
                              },
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    passwordController.togglePassword(),
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

                        const SizedBox(height: 20),

                        // login button
                        GetX<AuthController>(
                          builder: (controller) {
                            return MainButton(
                              onPressed: signUp,
                              title: 'Log in',
                              isLoading: controller.isLoading.value,
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        // forget password help
                        GestureDetector(
                          onTap: () => Get.to(() => const PasswordResetView()),
                          child: CustomRichText(
                            text1: 'Forget your login details? ',
                            text2: 'Get help logging in.',
                            text1Style: AppTheme.textStyle(context)
                                .titleSmall!
                                .copyWith(
                                  color: AppColors.greyColor,
                                  fontSize: 11,
                                ),
                            text2Style: AppTheme.textStyle(context)
                                .titleSmall!
                                .copyWith(
                                  color: AppColors.deepButtonColor,
                                  fontSize: 11,
                                ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // or widget
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(child: Divider()),
                            const SizedBox(width: 10),
                            Text('OR',
                                style: AppTheme.textStyle(context).labelMedium),
                            const SizedBox(width: 10),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // facebook widget
                        MainButton(
                          onPressed: () {
                            onLoading(context, 'Loading');
                          },
                          iconData: FontAwesomeIcons.facebook,
                          title: 'Contiue as Prince Ampomah',
                          bgColor: Colors.blue.shade700,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Divider(),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => Get.to(() => const SignUpView()),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CustomRichText(
                            text1: 'Don\'t have an account? ',
                            text2: 'Sign up.',
                            text1Style: AppTheme.textStyle(context)
                                .titleSmall!
                                .copyWith(
                                  color: AppColors.greyColor,
                                  fontSize: 11,
                                ),
                            text2Style: AppTheme.textStyle(context)
                                .titleSmall!
                                .copyWith(
                                  color: AppColors.deepButtonColor,
                                  fontSize: 11,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signUp() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await AuthController.instance.signUserIn(email!, password!);
    }
  }
}
