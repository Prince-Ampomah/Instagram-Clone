import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/theme/theme.dart';
import 'package:instagram_clone/core/widgets/cus_form_field.dart';
import 'package:instagram_clone/core/widgets/cus_main_button.dart';
import 'package:instagram_clone/core/widgets/cus_rich_text.dart';
import 'package:instagram_clone/view/authentication/sign_up_view/sign_up_view.dart';
import 'package:instagram_clone/view/layout/app_layout.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

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
                        const SizedBox(height: 20),

                        // login button
                        MainButton(
                          onPressed: () {
                            Get.off(AppLayoutView());
                          },
                          title: 'Log in',
                        ),

                        const SizedBox(height: 20),

                        // forget password help
                        GestureDetector(
                          onTap: () {},
                          child: CustomRichText(
                            text1: 'Forget your login details? ',
                            text2: 'Get help logging in.',
                            text1Style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: AppColors.greyColor,
                                  fontSize: 11,
                                ),
                            text2Style: Theme.of(context)
                                .textTheme
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
                                style: Theme.of(context).textTheme.labelMedium),
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
                SizedBox(height: size.height * 0.05),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Divider(),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => Get.to(const SignUpView()),
                        child: CustomRichText(
                          text1: 'Don\'t have an account? ',
                          text2: 'Sign up.',
                          text1Style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: AppColors.greyColor,
                                    fontSize: 11,
                                  ),
                          text2Style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: AppColors.deepButtonColor,
                                    fontSize: 11,
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
}
