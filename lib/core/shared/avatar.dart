import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  const AvatarImage({super.key, required this.imageUrl, required this.radius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CircleAvatar(
        child: (imageUrl != null && imageUrl!.isNotEmpty)
            ? CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorWidget: (context, url, error) => const Icon(Icons.person),
        )
            : const Icon(Icons.person),
      ),
    );
  }
}
