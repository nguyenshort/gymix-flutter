import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:gymix/services/auth_service.dart';

import '../../theme/color.dart';
import '../../theme/input.dart';

class SettingTab extends StatelessWidget {
  SettingTab({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final AuthService authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Row(
            children: const [


              Text("Cài Đặt", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),

              Spacer(),

            ],
          ),
        ),

        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                child: Column(
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Tên người dùng"),

                        const SizedBox(height: 8),

                        TextFormField(
                          onChanged: (text) => authService.formData.value?.name = text,
                          initialValue: authService.formData.value?.name,
                          decoration: kPrimaryInput.copyWith(
                              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              hintText: 'Tên Người Dùng',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none
                                ),
                              )
                          ),
                          cursorColor: kTextColor.withOpacity(0.5),
                          // The validator receives the text that the user has entered.
                          validator: ValidationBuilder(requiredMessage: 'Tên là bắt buộc')
                              .minLength(6, 'Tên quá ngắn')
                              .build(),
                        ),
                      ],
                    ),

                    const SizedBox( height: 25 ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Sở thích"),

                        const SizedBox(height: 8),

                        TextFormField(
                          onChanged: (text) => authService.formData.value?.hobby = text,
                          initialValue: authService.formData.value?.hobby,
                          decoration: kPrimaryInput.copyWith(
                              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              hintText: 'Nhập sở thích',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none
                                ),
                              )
                          ),
                          cursorColor: kTextColor.withOpacity(0.5),
                        ),
                      ],
                    ),

                    const SizedBox( height: 25 ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Địa chỉ"),

                        const SizedBox(height: 8),

                        TextFormField(
                          onChanged: (text) => authService.formData.value?.address = text,
                          initialValue: authService.formData.value?.address,
                          decoration: kPrimaryInput.copyWith(
                              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              hintText: 'Nhập địa chỉ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none
                                ),
                              )
                          ),
                          cursorColor: kTextColor.withOpacity(0.5),
                        ),
                      ],
                    ),

                    const SizedBox( height: 25 ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Giới thiệu"),

                        const SizedBox(height: 8),

                        TextFormField(
                          onChanged: (text) => authService.formData.value?.about = text,
                          initialValue: authService.formData.value?.about,
                          decoration: kPrimaryInput.copyWith(
                              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              hintText: 'Giới thiệu bản thân',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none
                                ),
                              )
                          ),
                          maxLines: 8,
                          cursorColor: kTextColor.withOpacity(0.5),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextButton(
                        style: ElevatedButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            authService.updateUserInfo();
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            color: kTextColor,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: const Center(
                              child: Text('Cập Nhật', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500)),
                            ),
                          ),
                        )
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextButton(
                        style: ElevatedButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () {
                          authService.signOut();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            color: Colors.deepOrangeAccent,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: const Center(
                              child: Text('Đăng Xuất', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500)),
                            ),
                          ),
                        )
                    )

                  ],
                ),
              ),
            )
        )
      ],
    );
  }
}
