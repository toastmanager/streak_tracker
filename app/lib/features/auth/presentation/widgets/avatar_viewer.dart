import 'package:app/features/auth/domain/cubit/auth_cubit.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarViewer extends StatelessWidget {
  const AvatarViewer({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ExtendedImage.network(
          imageUrl,
          mode: ExtendedImageMode.gesture,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close_rounded)),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title:
                              Text('Вы уверены что хотите удалить аватарку?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () async {
                                if (context.mounted) {
                                  context.read<AuthCubit>().removeAvatar();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                'Удалить',
                                style:
                                    TextTheme.of(context).bodyMedium?.copyWith(
                                          color: ColorScheme.of(context).error,
                                        ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.delete_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
