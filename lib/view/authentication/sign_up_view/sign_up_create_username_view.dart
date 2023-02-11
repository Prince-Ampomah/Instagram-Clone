import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../../core/widgets/cus_form_field.dart';
import '../../../core/widgets/cus_main_button.dart';

class CreateUsernameView extends StatelessWidget {
  const CreateUsernameView({super.key});

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
                  'CREATE USERNAME',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Add a username. You can change this at any time.',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
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
                ),
                const SizedBox(height: 20),
                MainButton(
                  onPressed: () {},
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
