import 'package:flutter/material.dart';
import '../bloc/workspace_bloc.dart';

class WorkspaceHeader extends StatelessWidget {
  final WorkspaceState state;

  const WorkspaceHeader({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.medical_information_outlined, color: Color(0xFF0D9488), size: 32),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Clinical Workspace',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 16),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text('Back'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey.shade700,
                side: BorderSide(color: Colors.grey.shade300),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Smart report editor & RAG assistant for islam sayed',
          style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 20,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _buildHeaderInfo(Icons.person_outline, 'islam sayed'),
            _buildHeaderInfo(Icons.calendar_today_outlined, 'Jun 23, 2026'),
            _buildHeaderInfo(Icons.access_time, '02:00 PM'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF0D9488),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Completed',
                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade400),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
      ],
    );
  }
}
