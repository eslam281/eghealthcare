import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/xray_cubit.dart';

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
          child: Row(
            children: [
              Expanded(child: UploadSection()),
              SizedBox(width: 16),
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Analysis Result", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),

                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(state.image, fit: BoxFit.cover),
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
                      Text("Preliminary Diagnosis: ${state.diagnosis}"),
                      const SizedBox(height: 5),
                      Text("Confidence: ${state.confidence.toStringAsFixed(1)}%"),
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
