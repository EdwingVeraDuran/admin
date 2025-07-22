import 'package:shadcn_flutter/shadcn_flutter.dart';

class SingleInputDialog extends StatelessWidget {
  final String title;
  final String placeholder;
  final String? value;
  final void Function(String) onSubmitted;
  const SingleInputDialog({
    super.key,
    required this.title,
    required this.placeholder,
    this.value,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        initialValue: value,
        onSubmitted: (value) {
          closeOverlay(context);
          onSubmitted(value);
        },
        placeholder: Text(placeholder),
      ),
    ).sized(width: 300);
  }
}
