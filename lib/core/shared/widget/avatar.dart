import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double radius;
  final void Function() onTap;
  const AvatarImage({super.key, required this.imageUrl, required this.radius, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child:(imageUrl != null && imageUrl!.isNotEmpty) ?
        CircleAvatar(
            child: CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorWidget: (context, url, error) => const Icon(Icons.person),
            )
        ) :
        CircleAvatar(
            backgroundColor: Colors.greenAccent.withAlpha(30),
            child: Text(name[0],style:
            TextStyle(color: Colors.green.withGreen(190)),),
          ),
      ),
    );
  }
}
