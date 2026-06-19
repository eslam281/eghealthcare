import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/workspace_bloc.dart';

class ClinicalWorkspaceScreen extends StatelessWidget {
  const ClinicalWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkspaceBloc()..add(LoadWorkspaceData('patient_123')),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: _buildAppBar(),
        body: BlocBuilder<WorkspaceBloc, WorkspaceState>(
          builder: (context, state) {
            if (state.isLoading && state.reportText.isEmpty && state.chatHistory.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                bool isDesktop = constraints.maxWidth > 800; // نقطة الفصل بين الموبايل والويب

                if (isDesktop) {
                  // شكل الويب: عمودين جنب بعض
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: _buildLeftPanel(context, state)),
                        const SizedBox(width: 24),
                        Expanded(flex: 4, child: _buildRightPanel(context, state)),
                      ],
                    ),
                  );
                } else {
                  // شكل الموبايل: تحت بعض مع Scroll
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // الحل: نحدد طول ثابت للـ LeftPanel في الموبايل عشان الـ TextField اللي جواه الـ Expanded
                        SizedBox(
                          height: 500, // الارتفاع المناسب للـ Editor والأزرار في الموبايل
                          child: _buildLeftPanel(context, state),
                        ),
                        const SizedBox(height: 24),
                        // نحدد طول ثابت للـ Chat في الموبايل عشان الـ Scroll
                        SizedBox(
                          height: 600,
                          child: _buildRightPanel(context, state),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  // --- AppBar ---
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'Clinical Workspace',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          label: const Text('Back', style: TextStyle(color: Colors.black54)),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  // --- Left Panel: Smart Report Editor ---
  Widget _buildLeftPanel(BuildContext context, WorkspaceState state) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Smart Report Editor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Templates Row
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildTemplateChip('Smart Prescription', Icons.edit_document),
                _buildTemplateChip('Clinical Note (SOAP)', Icons.note_alt_outlined),
                _buildTemplateChip('Follow-up Plan', Icons.calendar_today),
              ],
            ),
            const SizedBox(height: 24),
            // Text Editor Area
            const Text('Consultation Report / Prescription',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                maxLines: null, // بيسمح للـ TextField يكبر ويملا المكان
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Write diagnosis, clinical notes, medications...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                onChanged: (text) {
                  context.read<WorkspaceBloc>().add(UpdateReportText(text));
                },
              ),
            ),
            const SizedBox(height: 16),
            // Submit Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade300,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  context.read<WorkspaceBloc>().add(SaveReport());
                },
                child: state.isLoading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white))
                    : const Text('Save report & complete visit'),
              ),
            )
          ],
        ),
      ),
    );
  }

  // --- Right Panel: RAG Agent & Insights ---
  Widget _buildRightPanel(BuildContext context, WorkspaceState state) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('RAG Agent & Insights',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Auto-generated Insights (بتتغير حسب الـ State)
            if (!state.hasHistory)
              _buildEmptyInfoBox('No History', 'No prior medical records found.')
            else
              _buildFilledInsights(),

            const SizedBox(height: 20),

            // RAG Chat Area
            const Text('CONTEXTUAL RAG CHAT',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 8),

            // Suggestion Chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChatSuggestion('Summarize the last 3 visits.'),
                _buildChatSuggestion('Any drug allergies?'),
              ],
            ),
            const SizedBox(height: 12),

            // Chat Messages List
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200), // ✅ تعديل هنا أيضاً لتجنب أي مشاكل مستقبلاً
                ),
                child: ListView.builder(
                  itemCount: state.chatHistory.length,
                  itemBuilder: (context, index) {
                    final msg = state.chatHistory[index];
                    return Align(
                      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: msg.isUser ? Colors.teal.shade600 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: msg.isUser ? null : Border.all(color: Colors.grey.shade300), // ✅ تعديل هنا أيضاً
                        ),
                        child: Text(
                          msg.text,
                          style: TextStyle(color: msg.isUser ? Colors.white : Colors.black87),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Chat Input Field
            _buildChatInput(context),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildTemplateChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300), // ✅ تم التعديل هنا لـ Border.all
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.teal),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildEmptyInfoBox(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200), // ✅ تم التعديل هنا لـ Border.all
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, size: 20, color: Colors.grey),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildFilledInsights() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade200), // ✅ تم التعديل هنا لـ Border.all
          ),
          child: const Text('⚠️ Allergy Alert: Penicillin'),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200), // ✅ تم التعديل هنا لـ Border.all
          ),
          child: const Text('💊 Recent Medications: Losartan 50mg, Metformin 500mg'),
        ),
      ],
    );
  }

  Widget _buildChatSuggestion(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.black87)),
    );
  }

  Widget _buildChatInput(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'e.g. Did they report knee pain before?',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                context.read<WorkspaceBloc>().add(SendChatMessage(value));
                controller.clear();
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: Colors.teal.shade300,
          child: IconButton(
            icon: const Icon(Icons.send, color: Colors.white, size: 18),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<WorkspaceBloc>().add(SendChatMessage(controller.text));
                controller.clear();
              }
            },
          ),
        )
      ],
    );
  }
}