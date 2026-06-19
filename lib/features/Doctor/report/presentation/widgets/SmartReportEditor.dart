import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/workspace_bloc.dart';

class SmartReportEditor extends StatelessWidget {
  final WorkspaceState state;

  const SmartReportEditor({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome_outlined, color: Color(0xFF0D9488), size: 22),
              SizedBox(width: 10),
              Text('Smart Report Editor',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF374151))),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Document consultation for islam sayed',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          ),
          const SizedBox(height: 28),
          Text(
            'AI REPORT TEMPLATES',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey.shade400, letterSpacing: 0.5),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildTemplateChip(
                  context,
                  'Smart Prescription',
                  Icons.edit_document,
                  'AI draft Rx based on history & weight',
                  () => context.read<WorkspaceBloc>().add(UpdateReportText('Smart Prescription Template selected...')),
                ),
                const SizedBox(width: 16),
                _buildTemplateChip(
                  context,
                  'Clinical Note (SOAP)',
                  Icons.note_alt_outlined,
                  'Structured consultation draft',
                  () => context.read<WorkspaceBloc>().add(UpdateReportText('SOAP Note Template selected...')),
                ),
                const SizedBox(width: 16),
                _buildTemplateChip(
                  context,
                  'Follow-up Plan',
                  Icons.calendar_today,
                  'Care instructions & monitoring',
                  () => context.read<WorkspaceBloc>().add(UpdateReportText('Follow-up Plan Template selected...')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              const Text('Consultation Report / Prescription',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFF374151))),
              const Spacer(),
              Text('Editable draft', style: TextStyle(color: Colors.grey.shade400, fontSize: 13, fontStyle: FontStyle.italic)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: TextField(
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: const TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF1F2937)),
              decoration: InputDecoration(
                hintText: 'Write diagnosis, clinical notes, medications, and follow-up instructions...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                contentPadding: const EdgeInsets.all(24),
                border: InputBorder.none,
              ),
              onChanged: (text) {
                context.read<WorkspaceBloc>().add(UpdateReportText(text));
              },
            ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D9488),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                context.read<WorkspaceBloc>().add(SaveReport());
              },
              child: state.isLoading
                  ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text('Save report & complete visit', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTemplateChip(BuildContext context, String label, IconData icon, String subtitle, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 240,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 18, color: const Color(0xFF0D9488)),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      label,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF374151)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade400, height: 1.3),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
