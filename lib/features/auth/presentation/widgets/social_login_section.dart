import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SocialLoginSection extends StatelessWidget {
  final VoidCallback onGooglePressed;
  final String text;

  const SocialLoginSection({
    super.key,
    required this.onGooglePressed,
    this.text = "Or continue with",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        /// ---- Divider with text ----
        Row(
          children: [
            const Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Expanded(child: Divider(thickness: 1)),
          ],
        ),

        const SizedBox(height: 20),

        /// ---- Google Button ----
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              side: BorderSide(color: Colors.grey.shade300),
              backgroundColor: Colors.white,
            ),
            onPressed: onGooglePressed,
            icon: const Icon(Icons.sports_volleyball_rounded)
            // Image.asset(
            //   "assets/images/google.png", // حط لوجو جوجل هنا
            //   height: 22,
            // )
            ,
            label: const Text(
              "Continue with Google",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
