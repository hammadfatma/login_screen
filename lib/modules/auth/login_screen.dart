import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/modules/auth/register_screen.dart';
import 'package:loginscreen/modules/profiles/profile_screen.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/cubit/auth_cubit.dart';
import 'package:loginscreen/shared/network/local/cache_helper.dart';
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
    nameController.text =
        CacheHelper.sharedPreferences?.getString("userName") ?? '';
    passController.text =
        CacheHelper.sharedPreferences?.getString("password") ?? '';
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccessLoginState) {
          showToast(text: 'Successfuly, logined', state: ToastStates.success);
          navigateAndFinish(context, const ProfileScreen());
        }
        if (state is AuthFailureLoginState ||
            state is AuthUnauthorizedLoginState) {
          showToast(
              text: 'Failed, unauthorized user', state: ToastStates.error);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            suffix: cubit.suffix,
                            isPassword: cubit.isPassword,
                            suffixPressed: () {
                              cubit.changePasswordVisibility();
                            },
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
                          rememberPart(
                              check: cubit.check,
                              onTap: () {
                                cubit.changeRememberVisibility();
                              },
                              lastPart: 'Forgot password?'),
                          const SizedBox(
                            height: 22.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! AuthLoadingLoginState,
                            builder: (context) {
                              return defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.loginForUser(nameController.text,
                                          passController.text);
                                    }
                                  },
                                  text: 'Log in');
                            },
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(
                            height: 22.0,
                          ),
                          checkAccount(
                            onTap: () {
                              navigateAndFinish(
                                context,
                                RegisterScreen(
                                  cubit: cubit,
                                ),
                              );
                            },
                            firstPart: 'Don’t have an account?',
                            lastPart: 'Register',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
