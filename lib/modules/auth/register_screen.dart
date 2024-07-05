import 'package:flutter/material.dart';
import 'package:loginscreen/modules/auth/login_screen.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/styles/styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

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
              'Create new account',
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
                        'Email',
                        style: AppStyles.styleRegular14,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        suffix: Icons.cancel_outlined,
                        suffixPressed: () {
                          emailController.clear();
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
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
                      rememberPart(onTap: () {}, lastPart: 'Have a problem?'),
                      const SizedBox(
                        height: 22.0,
                      ),
                      defaultButton(function: () {}, text: 'Register'),
                      const SizedBox(
                        height: 22.0,
                      ),
                      checkAccount(
                        onTap: () {
                          navigateAndFinish(context, const LoginScreen());
                        },
                        firstPart: 'Already have an account?',
                        lastPart: 'Log in',
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
