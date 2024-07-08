import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginscreen/shared/styles/styles.dart';

Widget backgroundPart({required bool isProfileImage, String? profileImage}) =>
    Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          'assets/images/backgroundFrame.png',
          width: double.infinity,
          fit: BoxFit.contain,
        ),
        Positioned(
          left: 140,
          right: 140,
          bottom: -50,
          child: isProfileImage
              ? Container(
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 4.0,
                        color: const Color(0xff000000).withOpacity(0.15),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.network(
                      profileImage!,
                    ),
                  ),
                )
              : SizedBox(
                  width: 116,
                  height: 116,
                  child: Image.asset(
                    'assets/images/backgroundRectangle.png',
                  ),
                ),
        ),
      ],
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChanged,
  void Function()? onTap,
  bool isPassword = false,
  bool isClickable = true,
  IconData? suffix,
  void Function()? suffixPressed,
  required String? Function(String?)? validate,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClickable,
      validator: validate,
      decoration: InputDecoration(
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  size: 16.0,
                  color: const Color(0xff808194),
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          gapPadding: 8.0,
          borderSide: const BorderSide(
            color: Color(0xff808194),
            width: 0.5,
          ),
        ),
      ),
    );
Widget rememberPart(
        {required void Function()? onTap,
        String? lastPart,
        IconData? check,
        BuildContext? context}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                check,
                size: 16,
                color: const Color(0xff808194),
              ),
              const SizedBox(
                width: 8.0,
              ),
              const Text(
                'Remember me',
                style: AppStyles.styleBold14,
              ),
            ],
          ),
        ),
        Text(
          lastPart!,
          textAlign: TextAlign.center,
          style: AppStyles.styleBold14.copyWith(
            decoration: TextDecoration.underline,
            decorationColor: const Color(0xff4F90F0),
            decorationThickness: 1.5,
          ),
        ),
      ],
    );
Widget defaultButton({
  double width = double.infinity,
  Color background = const Color(0xff007BFF),
  double radius = 4.0,
  required void Function()? function,
  required String text,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      width: width,
      height: 44.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppStyles.styleBold14.copyWith(
            color: const Color(0xffFFFFFF),
          ),
        ),
      ),
    );
Widget checkAccount(
        {required void Function()? onTap,
        String? firstPart,
        String? lastPart}) =>
    Row(
      children: [
        Text(
          firstPart!,
          style: AppStyles.styleRegular14.copyWith(
            color: const Color(0xff2A2B2E),
          ),
        ),
        const SizedBox(
          width: 6.0,
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            lastPart!,
            textAlign: TextAlign.center,
            style: AppStyles.styleBold14.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: const Color(0xff4F90F0),
              decorationThickness: 1.5,
            ),
          ),
        ),
      ],
    );
void navigateAndFinish(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (Route<dynamic> route) => false,
  );
}

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
