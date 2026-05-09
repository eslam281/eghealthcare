

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/xray_cubit.dart';
import '../widgets/fullScreenImage.dart';

class XRayAnalysisPage extends StatelessWidget {
  const XRayAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => XRayCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text("AI X-Ray Analysis")),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              UploadSection(),

              SizedBox(height: 15),
              Expanded(child: ResultSection()),
            ],
          ),
        ),
      ),
    );
  }
}
class UploadSection extends StatelessWidget {
  const UploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<XRayCubit>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Image Upload", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("Select an X-ray image file to begin."),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: () => cubit.pickImage(),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: BlocBuilder<XRayCubit, XRayState>(
                builder: (context, state) {
                  if (cubit.selectedImage == null) {
                    return const Center(child: Text("Choose file"));
                  }
                  return Image.file(cubit.selectedImage!, fit: BoxFit.cover);
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: BlocBuilder<XRayCubit, XRayState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state is XRayLoading ? null : () => cubit.analyzeImage(),
                  child: state is XRayLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Start Instant Analysis"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class ResultSection extends StatelessWidget {
  const ResultSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: BlocBuilder<XRayCubit, XRayState>(
        builder: (context, state) {
          if (state is XRayLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is XRaySuccess) {
            final cubit = context.read<XRayCubit>();
            final image = cubit.selectedImage;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Analysis Result", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                      PageRouteBuilder(
                        pageBuilder: (_,_,_) =>
                            BlocProvider.value(
                              value: cubit,
                              child: FullScreenImagePage(model: state.model,
                              image: image!,),
                            ),
                        transitionDuration: const Duration(milliseconds: 300),
                      )
                      );
                    },
                    child: Hero(
                      tag: "xray_image",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final model = state.model;
                            final imgWidth = model.image?.width ?? 1;
                            final imgHeight = model.image?.height ?? 1;

                            return Stack(
                              children: [
                                // الصورة
                                Positioned.fill(
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                // رسم الـ boxes
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
                                            color: pred.confidence! > 0.8 ? Colors.red : Colors.orange
                                            , width: 2),
                                      ),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          color: Colors.black,
                                          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                                          child: Text(
                                            "[${pred.kind}] ${(pred.confidence! * 100).toStringAsFixed(0)}%",
                                            style: const TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            );
                          },
                        )
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Preliminary Diagnosis: ${state.model.top}"),
                      const SizedBox(height: 5),
                      Text("Confidence: ${(state.model.confidence! * 100).toStringAsFixed(1)}%"),
                    ],
                  ),
                ),
              ],
            );
          }

          if (state is XRayError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text("No result yet"));
        },
      ),
    );
  }
}
