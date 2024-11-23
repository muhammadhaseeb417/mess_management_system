import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/helpers/helper_functions.dart';
import '../login/widgets/custom_text_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: isDark ? TColors.white : TColors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          TSizes.defaultSpace,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.xl,
              ),
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            expands: false,
                            decoration: const InputDecoration(
                              hintText: TTexts.firstName,
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: TSizes.lg,
                        ),
                        Expanded(
                          child: TextFormField(
                            expands: false,
                            decoration: const InputDecoration(
                              hintText: TTexts.lastName,
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const CustomTextField(
                      hintText: TTexts.session,
                      prefixIcon: Icon(Icons.info),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const CustomTextField(
                      hintText: TTexts.department,
                      prefixIcon: Icon(Icons.add_home_work_rounded),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const CustomTextField(
                      hintText: TTexts.rollNo,
                      prefixIcon: Icon(Icons.assignment_ind_rounded),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    const CustomTextField(
                      hintText: TTexts.cnic,
                      prefixIcon: Icon(Icons.add_card_rounded),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                        ),
                        const SizedBox(
                          width: TSizes.sm,
                        ),
                        Row(
                          children: [
                            Text(
                              "${TTexts.iAgreeTo} ",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              TTexts.privacyPolicy,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .apply(
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        isDark ? TColors.white : TColors.black,
                                  ),
                            ),
                            Text(
                              " ${TTexts.and} ",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              TTexts.termsOfUse,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .apply(
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        isDark ? TColors.white : TColors.black,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.xl * 3,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text(TTexts.createAccount),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
