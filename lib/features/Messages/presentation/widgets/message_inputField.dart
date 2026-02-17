import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MessageInputField extends StatefulWidget {
  const MessageInputField({super.key});

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {

  final TextEditingController controller = TextEditingController();

  bool showEmoji = false;

  /// send message
  void sendMessage() {

    if (controller.text.trim().isEmpty) return;

    print("Send: ${controller.text}");

    controller.clear();

    setState(() {});
  }

  /// pick file
  Future<void> pickFile() async {

    FilePickerResult? result =
    await FilePicker.platform.pickFiles();

    if (result != null) {

      String fileName = result.files.single.name;

      print("Picked file: $fileName");
    }
  }

  /// toggle emoji keyboard
  void toggleEmoji() {

    FocusScope.of(context).unfocus();

    setState(() {

      showEmoji = !showEmoji;

    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        /// INPUT FIELD
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Color(0xffE5E7EB),
              ),
            ),
          ),
          child: Row(
            children: [

              /// Attachment button
              IconButton(
                onPressed: pickFile,
                icon: const Icon(
                  Icons.attach_file,
                  color: Color(0xff6B7280),
                ),
              ),

              /// Text field
              Expanded(
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xffF3F4F6),
                    borderRadius:
                    BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [

                      /// Text input
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration:
                          const InputDecoration(
                            hintText: "Type a message...",
                            hintStyle: TextStyle(
                              color: Color(0xff9CA3AF),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),

                      /// Emoji button
                      IconButton(
                        onPressed: toggleEmoji,
                        icon: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: Color(0xff6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              /// Send button
              Container(
                height: 42,
                width: 42,
                decoration: const BoxDecoration(
                  color: Color(0xff14B8A6),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// EMOJI PICKER
        Offstage(
          offstage: !showEmoji,
          child: EmojiPicker(
            textEditingController: controller,
            config: const Config(

              height: 300,

              emojiViewConfig: EmojiViewConfig(
                emojiSizeMax: 28,
                columns: 7,
              ),

              categoryViewConfig: CategoryViewConfig(),

              skinToneConfig: SkinToneConfig(),

              bottomActionBarConfig:
              BottomActionBarConfig(),

              searchViewConfig: SearchViewConfig(),

            ),
          ),
        )

      ],
    );
  }
}
