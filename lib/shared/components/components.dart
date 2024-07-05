import 'package:flutter/material.dart';
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
Widget rememberPart({required void Function()? onTap, String? lastPart}) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onTap,
          child: const Row(
            children: [
              Icon(
                Icons.check_box_outline_blank_outlined,
                size: 16,
                color: Color(0xff808194),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
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
          onTap: () {},
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
Widget buildIndicator() => Container(
      width: 134.0,
      height: 5.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.5),
        color: const Color(0xff344054).withOpacity(0.85),
      ),
    );
