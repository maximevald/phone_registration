import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:test_project/presentation/blocs/registration_cubit/registration_cubit.dart';
import 'package:test_project/presentation/pages/pages.dart';

import 'package:test_project/presentation/widgets/registration/registration_widgets.dart';
import 'package:test_project/servicies/auth_service.dart';

final maskFormatter = MaskTextInputFormatter(
  mask: ' (###) ### ## ##',
  filter: {'#': RegExp('[0-9]')},
);

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final TextEditingController _phoneController =
      TextEditingController(text: ' ');

  @override
  Widget build(BuildContext context) {
    const textColor = Color.fromRGBO(79, 79, 79, 1);
    const orange = Color.fromRGBO(255, 184, 0, 1);
    const lightGrey = Color.fromRGBO(167, 167, 167, 1);

    return BlocProvider(
      create: (context) => RegistrationCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.back),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const StepsCircles(),
                    const SizedBox(height: 25),
                    const Text(
                      'Регистрация',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 25),
                    const SizedBox(
                      width: 200,
                      child: Text(
                        'Введите номер телефона для регистрации',
                        style: TextStyle(color: textColor, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Номер телефона',
                            style: TextStyle(color: textColor),
                          ),
                          const SizedBox(height: 6),
                          TextField(
                            cursorColor: textColor,
                            decoration: InputDecoration(
                              prefix: Text(
                                '+7',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromRGBO(217, 217, 217, 1),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: orange,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [maskFormatter],
                            controller: _phoneController,
                            onChanged: (value) {
                              context
                                  .read<RegistrationCubit>()
                                  .updatePhone(maskFormatter.unmaskText(value));
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 120),
                    BlocBuilder<RegistrationCubit, bool>(
                      builder: (context, isAvailable) {
                        return ElevatedButton(
                          onPressed: isAvailable
                              ? () {
                                  AuthService.sentOtp(
                                    phone: '+7${_phoneController.text}',
                                    errorStep: () =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Error in sending OTP",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  );

                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (context) => SubmitionPage(
                                        phoneNumber:
                                            '+7${_phoneController.text}',
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            fixedSize: const Size(320, 65),
                            disabledBackgroundColor: lightGrey,
                            backgroundColor: orange,
                          ),
                          child: const Text(
                            'Отправить смс-код',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {},
                      child: const SizedBox(
                        width: 270,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Нажимая на данную кнопку, вы даете согласие на обработку ',
                                style: TextStyle(
                                  color: lightGrey,
                                  fontSize: 12,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'персональных данных',
                                style: TextStyle(
                                  color: orange,
                                  fontSize: 12,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
