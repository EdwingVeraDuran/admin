import 'package:admin/shared/widgets/field.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NameField extends StatelessWidget {
  final String initialValue;
  final void Function(String)? onChanged;
  const NameField({super.key, required this.initialValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Field(
      label: 'Nombre',
      child: TextField(initialValue: initialValue, onChanged: onChanged),
    );
  }
}
