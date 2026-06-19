import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/workspace_bloc.dart';
import '../../data/models/chatMessage_model.dart';

class RagAgentInsights extends StatelessWidget {
  final WorkspaceState state;

  const RagAgentInsights({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.biotech_outlined, color: Color(0xFF0D9488), size: 24),
              SizedBox(width: 10),
              Text('RAG Agent & Insights',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF374151))),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Proactive context and patient history chat',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          ),
          const SizedBox(height: 32),
          Text(
            'AUTO-GENERATED INSIGHTS',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey.shade400, letterSpacing: 0.5),
          ),
          const SizedBox(height: 16),
          if (!state.hasHistory)
            _buildEmptyInfoBox('No History', 'No prior medical records found for this patient.')
          else
            _buildFilledInsights(),
          const SizedBox(height: 32),
          Text(
            'PATIENT TIMELINE',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey.shade400, letterSpacing: 0.5),
          ),
          const SizedBox(height: 16),
          if (!state.hasHistory)
            _buildTimelineEmpty()
          else
            _buildTimelineList(),
          const SizedBox(height: 32),
          Text(
            'CONTEXTUAL RAG CHAT',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey.shade400, letterSpacing: 0.5),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildChatSuggestion(context, 'Drug allergies?'),
                const SizedBox(width: 10),
                _buildChatSuggestion(context, 'Last diagnosis?'),
                const SizedBox(width: 10),
                _buildChatSuggestion(context, 'Summarize visits'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: state.chatHistory.isEmpty ? 120 : 350,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: state.chatHistory.isEmpty
                ? Center(
                    child: Text(
                      'Ask about patient history...',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    ),
                  )
                : ListView.builder(
                    itemCount: state.chatHistory.length,
                    itemBuilder: (context, index) {
                      final msg = state.chatHistory[index];
                      return _buildChatMessage(msg);
                    },
                  ),
          ),
          const SizedBox(height: 16),
          _buildChatInput(context),
        ],
      ),
    );
  }

  Widget _buildChatMessage(ChatMessage msg) {
    return Builder(
      builder: (context) {
        return Align(
          alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: msg.isUser ? const Color(0xFF0D9488) : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: Radius.circular(msg.isUser ? 12 : 0),
                bottomRight: Radius.circular(msg.isUser ? 0 : 12),
              ),
            ),
            child: Text(
              msg.text,
              style: TextStyle(
                color: msg.isUser ? Colors.white : const Color(0xFF374151),
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatSuggestion(BuildContext context, String text) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.read<WorkspaceBloc>().add(SendChatMessage(text)),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Text(text, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
        ),
      ),
    );
  }

  Widget _buildChatInput(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Ask anything...',
                hintStyle: TextStyle(color: Colors.grey.shade300, fontSize: 13),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
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
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF0D9488), size: 20),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<WorkspaceBloc>().add(SendChatMessage(controller.text));
                controller.clear();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildEmptyInfoBox(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 20, color: Colors.grey.shade400),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xFF374151))),
                const SizedBox(height: 6),
                Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineEmpty() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Icon(Icons.history, size: 18, color: Colors.grey.shade400),
          const SizedBox(width: 12),
          Text('No prior visits.', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildFilledInsights() {
    return Column(
      children: [
        _buildInsightCard(
          'Allergy Alert',
          'هذا المريض لديه حساسية شديدة من البنسلين (Penicillin) وذكرت في سجل #H4 التي تسببت رد فعل تحسسي في الزيارة الأولى لزيارة العيادة بتاريخ 10-05-2026',
          Colors.red.shade50,
          Colors.red.shade900,
          Icons.warning_amber_rounded,
        ),
        const SizedBox(height: 12),
        _buildInsightCard(
          'Recent Medications',
          'Losartan 50mg once daily, Metformin 500mg twice daily with meals',
          Colors.blue.shade50,
          Colors.blue.shade900,
          Icons.medical_services_outlined,
        ),
        const SizedBox(height: 12),
        _buildInsightCard(
          'Active Conditions',
          'الاصابة السريرية المعتمدة: المريض يعاني من مرض السكري من النوع الثاني وارتفاع ضغط الدم الدرجة الأولى وتوجد لديه حساسية في البلازما شديدة البنسلين تحت ملاحظة',
          Colors.teal.shade50,
          Colors.teal.shade900,
          Icons.electric_bolt_outlined,
        ),
      ],
    );
  }

  Widget _buildInsightCard(String title, String content, Color bgColor, Color textColor, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: textColor),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: textColor)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 12, height: 1.5),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineList() {
    return Column(
      children: [
        _buildTimelineItem('note', '2026-06-15', 'Follow-up Visit - Medication Adjustment', 'Dry cough noted due to Capazide. Discontinued Capazide and prescribed Losartan 50mg.', true),
        _buildTimelineItem('prescription', '2026-05-17', 'Lab Results Review & Prescription', 'Confirmed Type 2 Diabetes and Hypertension. Prescribed Metformin and Capazide.', true),
        _buildTimelineItem('diagnosis', '2026-05-10', 'Initial Consultation - Internal Medicine', 'Initial screening for Hypertension and Diabetes Mellitus. Patient has Penicillin allergy.', false),
      ],
    );
  }

  Widget _buildTimelineItem(String type, String date, String title, String subtitle, bool showLine) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.teal.shade300, width: 2),
                ),
                child: Icon(
                  type == 'prescription' ? Icons.medical_services_outlined : type == 'diagnosis' ? Icons.biotech_outlined : Icons.edit_note,
                  size: 14,
                  color: Colors.teal.shade300,
                ),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey.shade200,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(type, style: TextStyle(fontSize: 10, color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.calendar_today, size: 10, color: Colors.grey.shade400),
                    const SizedBox(width: 4),
                    Text(date, style: TextStyle(fontSize: 11, color: Colors.grey.shade400)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 12, height: 1.4)),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
