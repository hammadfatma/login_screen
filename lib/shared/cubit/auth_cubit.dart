import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginscreen/models/login_model.dart';
import 'package:loginscreen/models/user.dart';
import 'package:loginscreen/modules/auth/login_screen.dart';
import 'package:loginscreen/shared/components/components.dart';
import 'package:loginscreen/shared/network/local/cache_helper.dart';
import 'package:loginscreen/shared/network/remote/dio_helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.dioHelper) : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);
  final DioHelper dioHelper;
  LoginModel loginModel = LoginModel();
  Future<void> loginForUser(String userName, String password) async {
    try {
      emit(AuthLoadingLoginState());
      await dioHelper.loginUser(userName, password).then((value) async {
        if (value != null) {
          loginModel = LoginModel.fromJson(value);
          if (isRemembered) {
            await CacheHelper.sharedPreferences
                ?.setString("userName", loginModel.username!);
            await CacheHelper.sharedPreferences
                ?.setString("email", loginModel.email!);
            await CacheHelper.sharedPreferences
                ?.setString("password", password);
          }
          await CacheHelper.sharedPreferences
              ?.setString("token", loginModel.token!);
          // print(
          //     "userName: ${CacheHelper.sharedPreferences?.getString("userName") ?? 'no name'}");
          // print(
          //     "email: ${CacheHelper.sharedPreferences?.getString("email") ?? 'no email'}");
          // print(
          //     "password: ${CacheHelper.sharedPreferences?.getString("password") ?? 'no password'}");
          // print(
          //     "token: ${CacheHelper.sharedPreferences?.getString("token") ?? 'no token'}");
          emit(AuthSuccessLoginState());
        } else {
          emit(AuthFailureLoginState());
        }
      });
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 400) {
        emit(AuthUnauthorizedLoginState());
      } else {
        emit(AuthErrorLoginState(e.toString()));
      }
    }
  }

  Future<void> registerForUser(User model) async {
    emit(AuthLoadingRegisterState());
    await dioHelper.addUser(model).then((value) {
      emit(AuthSuccessRegisterState());
    }).catchError((error) {
      emit(AuthFailureRegisterState());
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(AuthChangePasswordVisibilityState());
  }

  IconData check = Icons.check_box_outline_blank;
  bool isRemembered = false;
  void changeRememberVisibility() {
    isRemembered = !isRemembered;
    check =
        isRemembered ? Icons.check_box_outlined : Icons.check_box_outline_blank;
    emit(AuthChangeRememberVisibilityState());
  }

  void signOut(context) {
    if (!isRemembered) {
      CacheHelper.sharedPreferences?.remove('userName');
      CacheHelper.sharedPreferences?.remove('email');
      CacheHelper.sharedPreferences?.remove('password');
    }
    CacheHelper.sharedPreferences?.remove('token');
    navigateAndFinish(context, const LoginScreen());
  }
}
