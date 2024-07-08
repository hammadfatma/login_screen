import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/models/user.dart';
import 'package:loginscreen/modules/auth/login_screen.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/cubit/auth_cubit.dart';
import 'package:loginscreen/shared/network/local/cache_helper.dart';
import 'package:loginscreen/shared/styles/styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.cubit});
  final AuthCubit cubit;
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
    nameController.text =
        CacheHelper.sharedPreferences?.getString("userName") ?? '';
    emailController.text =
        CacheHelper.sharedPreferences?.getString("email") ?? '';
    passController.text =
        CacheHelper.sharedPreferences?.getString("password") ?? '';
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccessRegisterState) {
          showToast(
              text: 'Successfuly, please go to login screen',
              state: ToastStates.success);
        }
        if (state is AuthFailureLoginState) {
          showToast(text: 'Failed, please try again', state: ToastStates.error);
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
                              lastPart: 'Have a problem?'),
                          const SizedBox(
                            height: 22.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! AuthLoadingRegisterState,
                            builder: (context) {
                              return defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      User userModel = User(
                                        username: nameController.text,
                                        email: emailController.text,
                                        password: passController.text,
                                      );
                                      cubit.registerForUser(userModel);
                                    }
                                  },
                                  text: 'Register');
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
                              navigateAndFinish(context, const LoginScreen());
                            },
                            firstPart: 'Already have an account?',
                            lastPart: 'Log in',
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
