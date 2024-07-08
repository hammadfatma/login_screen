import 'package:flutter/material.dart';
import 'package:loginscreen/models/login_model.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/cubit/auth_cubit.dart';
import 'package:loginscreen/shared/styles/styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var genderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final LoginModel model = AuthCubit.get(context).loginModel;
    nameController.text = model.username ?? 'no name';
    emailController.text = model.email ?? 'no email';
    genderController.text = model.gender ?? 'no gender';
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              backgroundPart(isProfileImage: true, profileImage: model.image),
              const SizedBox(
                height: 25,
              ),
              Text(
                '${model.firstName} ${model.lastName}',
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
                        isClickable: false,
                        controller: nameController,
                        type: TextInputType.name,
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
                        isClickable: false,
                        controller: emailController,
                        type: TextInputType.emailAddress,
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
                        'Gender',
                        style: AppStyles.styleRegular14,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      defaultFormField(
                        isClickable: false,
                        controller: genderController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your gender';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      defaultButton(
                        function: () {
                          AuthCubit.get(context).signOut(context);
                        },
                        text: 'Log out',
                        background: const Color(0xffDC3545),
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
  }
}
