import 'package:admin/shared/widgets/field.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CodeField extends StatelessWidget {
  final String initialValue;
  final void Function(String)? onChanged;
  const CodeField({super.key, required this.initialValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Field(
      label: 'Código',
      child: TextField(
        initialValue: initialValue,
        onChanged: onChanged,
        features: [InputFeature.leading(Icon(LucideIcons.barcode))],
      ),
    );
  }
}
