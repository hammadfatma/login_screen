import 'package:flutter/material.dart';
import 'package:loginscreen/modules/auth/register_screen.dart';
import 'package:loginscreen/modules/profiles/profile_screen.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/styles/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            backgroundPart(isProfileImage: false),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Log in to your account',
              textAlign: TextAlign.center,
              style: AppStyles.styleBold14.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: formKey,
                child: SizedBox(
                  height: 366,
                  child: ListView(
                    padding: EdgeInsetsDirectional.zero,
                    clipBehavior: Clip.none,
                    children: [
                      const Text(
                        'Username',
                        style: AppStyles.styleRegular14,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        suffix: Icons.cancel_outlined,
                        suffixPressed: () {
                          nameController.clear();
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your user name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      const Text(
                        'Password',
                        style: AppStyles.styleRegular14,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      defaultFormField(
                        controller: passController,
                        type: TextInputType.visiblePassword,
                        suffix: Icons.visibility_off_outlined,
                        suffixPressed: () {},
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      rememberPart(onTap: () {}, lastPart: 'Forgot password?'),
                      const SizedBox(
                        height: 22.0,
                      ),
                      defaultButton(
                          function: () {
                            navigateAndFinish(context, const ProfileScreen());
                          },
                          text: 'Log in'),
                      const SizedBox(
                        height: 22.0,
                      ),
                      checkAccount(
                        onTap: () {
                          navigateAndFinish(
                            context,
                            const RegisterScreen(),
                          );
                        },
                        firstPart: 'Don’t have an account?',
                        lastPart: 'Register',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            buildIndicator(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
