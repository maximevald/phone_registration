import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/entities/ticker.dart';
import 'package:test_project/presentation/blocs/timer_bloc/timer_bloc.dart';
import 'package:test_project/presentation/pages/pages.dart';
import 'package:test_project/presentation/widgets/widgets.dart';
import 'package:test_project/servicies/auth_service.dart';

class SubmitionPage extends StatefulWidget {
  const SubmitionPage({required this.phoneNumber, super.key});

  final String phoneNumber;

  @override
  State<SubmitionPage> createState() => _SubmitionPageState();
}

class _SubmitionPageState extends State<SubmitionPage> {
  late final TextEditingController _controller;
  String? one;
  String? two;
  String? three;
  String? four;
  String? five;
  String? six;
  late List<String?> _symbols;

  @override
  void initState() {
    _symbols = List.generate(6, (index) => null);
    _controller = TextEditingController();
    _symbols = [one, two, three, four, five, six];
    _controller.addListener(
      () {
        setState(
          () {
            _symbols = List.generate(6, (index) => null);
            final symbols = _controller.text.split('');
            for (var i = 0; i < symbols.length; i++) {
              _symbols[i] = symbols[i];
            }
            AuthService.loginWithOtp(otp: _controller.text).then(
              (value) {
                if (value == 'Success') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => const MainPage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                } else if (_symbols[5] != null && value != 'Success') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        value,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const textColor = Color.fromRGBO(79, 79, 79, 1);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const StepsSubmitionCircles(),
          const SizedBox(height: 25),
          const Text(
            'Подтверждение',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: 260,
            child: Text(
              'Введите код, который мы отправили в SMS на ${widget.phoneNumber}',
              style: const TextStyle(color: textColor, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _symbols.map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: 40,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(167, 167, 167, 1),
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          e ?? '',
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              Visibility.maintain(
                visible: false,
                child: SizedBox(
                  height: 20,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    controller: _controller,
                    autofocus: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          BlocProvider(
            create: (context) => TimerBloc(ticker: const Ticker()),
            child: BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                context.read<TimerBloc>().add(
                      TimerStarted(duration: state.duration),
                    );
                return state.duration != 0
                    ? TextButton(
                        onPressed: null,
                        child: Text(
                          '${state.duration} сек до повтора отправки кода',
                          style: const TextStyle(
                            color: textColor,
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          context.read<TimerBloc>().add(
                                const TimerStarted(duration: 60),
                              );
                          AuthService.sentOtp(
                              phone: widget.phoneNumber, errorStep: () {});
                          setState(() {
                            _controller.text = '';
                          });
                        },
                        child: const Text(
                          'Отправить код еще раз',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 184, 0, 1),
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
