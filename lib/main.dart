import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void onOpenDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return const AlertDialog(
            content: TextFieldAndButton(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Demo')),
        body: const Center(child: TextFieldAndButton()),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(onPressed: () => onOpenDialog(context));
        }),
      ),
    );
  }
}

class TextFieldAndButton extends StatefulWidget {
  const TextFieldAndButton({super.key});

  @override
  State<TextFieldAndButton> createState() => _TextFieldAndButtonState();
}

class _TextFieldAndButtonState extends State<TextFieldAndButton> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            focusNode: focusNode,
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Tap the button',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Tap me to insert text'),
            onPressed: () {
              final newText = '${controller.text} inserted';
              controller.value = controller.value.copyWith(
                text: newText,
                selection: TextSelection.collapsed(
                  offset: newText.length,
                ),
              );
              focusNode.requestFocus();
            },
          )
        ],
      ),
    );
  }
}
