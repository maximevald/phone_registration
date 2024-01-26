import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_project/presentation/blocs/name_cubit/profile_cubit.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return state.image != null
                  ? CircleAvatar(
                      radius: 45,
                      backgroundImage: FileImage(state.image!),
                    )
                  : Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromRGBO(227, 227, 227, 1),
                      ),
                      child: Icon(
                        CupertinoIcons.person_solid,
                        color: Color.fromRGBO(0, 152, 238, 1),
                        size: 80,
                      ),
                    );
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                width: 30,
                height: 30,
                child: const Icon(
                  Icons.more_horiz,
                  color: Color.fromRGBO(0, 152, 238, 1),
                  size: 30,
                ),
              ),
              onTap: () => _showActionSheet(context),
            ),
          ),
        ],
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Выберите фото',
        ),
        actions: <Widget>[
          ColoredBox(
            color: Colors.white,
            child: CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
                await bloc.updateImage(ImageSource.camera);
              },
              child: const Text(
                'Камера',
                style: TextStyle(
                  color: Color.fromRGBO(0, 152, 238, 1),
                ),
              ),
            ),
          ),
          ColoredBox(
            color: Colors.white,
            child: CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
                await bloc.updateImage(ImageSource.gallery);
              },
              child: const Text(
                'Галерея Фото',
                style: TextStyle(
                  color: Color.fromRGBO(0, 152, 238, 1),
                ),
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Закрыть',
            style: TextStyle(
              color: Color.fromRGBO(0, 152, 238, 1),
            ),
          ),
        ),
      ),
    );
  }
}
