import 'package:admin/shared/widgets/field.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DescriptionField extends StatelessWidget {
  final String initialValue;
  final void Function(String)? onChanged;
  const DescriptionField({
    super.key,
    required this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Field(
      label: 'Descripción',
      child: TextArea(
        initialHeight: 120,
        initialValue: initialValue,
        onChanged: onChanged,
      ),
    );
  }
}
