import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String? avatarUrl;

  const Avatar({
    super.key,
    this.size = 24,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    final avatarIcon = Icon(
      Icons.person_rounded,
      color: colors.onSurfaceVariant,
      size: size / 1.5,
    );

    return ClipOval(
      child: Container(
        color: colors.brightness == Brightness.dark
            ? colors.surfaceBright
            : colors.surfaceDim,
        width: size,
        height: size,
        child: avatarUrl != null
            ? CachedNetworkImage(
                imageUrl: avatarUrl!,
                errorWidget: (context, url, error) => avatarIcon,
                placeholder: (context, url) => avatarIcon,
                fit: BoxFit.cover,
              )
            : avatarIcon,
      ),
    );
  }
}
