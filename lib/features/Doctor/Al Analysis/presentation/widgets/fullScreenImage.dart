import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/xray_cubit.dart';

class FullScreenImagePage extends StatelessWidget {
  final dynamic model;
  final File? image;

  const FullScreenImagePage({super.key, required this.model, this.image});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<XRayCubit>();
    final image = cubit.selectedImage;

    if (image == null) return const SizedBox();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            InteractiveViewer(
              maxScale: 5,
              minScale: 1,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final imgWidth = model.image?.width ?? 1;
                  final imgHeight = model.image?.height ?? 1;

                  return Stack(
                    children: [
                      // الصورة
                      Positioned.fill(
                        child: Hero(
                          tag: "xray_image",
                          child: Image.file(
                            image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      // boxes
                      ...?model.predictions?.map((pred) {
                        final left = (pred.x! / imgWidth) * constraints.maxWidth;
                        final top = (pred.y! / imgHeight) * constraints.maxHeight;
                        final width = (pred.width! / imgWidth) * constraints.maxWidth;
                        final height = (pred.height! / imgHeight) * constraints.maxHeight;

                        return Positioned(
                          left: left - width / 2,
                          top: top - height / 2,
                          child: Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: pred.confidence! > 0.8
                                    ? Colors.red
                                    : Colors.orange,
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  );
                },
              ),
            ),


            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}