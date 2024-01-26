import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/presentation/blocs/name_cubit/profile_cubit.dart';

enum EditField {
  name('Ваше Имя'),
  surname('Ваша Фамилия'),
  email('Ваш Email');

  const EditField(this.text);
  final String text;
}

class EditPage extends StatefulWidget {
  const EditPage({required this.field, super.key});

  final EditField field;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController(
      text: widget.field == EditField.name
          ? context.read<ProfileCubit>().state.name
          : widget.field == EditField.surname
              ? context.read<ProfileCubit>().state.surname
              : context.read<ProfileCubit>().state.email,
    );
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(widget.field.text),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: const Color.fromRGBO(0, 152, 238, 1),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: CupertinoTextField(
          controller: _textController,
          onChanged: (value) {
            final bloc = context.read<ProfileCubit>();

            switch (widget.field) {
              case EditField.name:
                bloc.updateName(value);
              case EditField.surname:
                bloc.updateSurname(value);
              case EditField.email:
                bloc.updateEmail(value);
            }
          },
          padding: const EdgeInsets.all(12),
          placeholder: widget.field.text,
        ),
      ),
    );
  }
}
