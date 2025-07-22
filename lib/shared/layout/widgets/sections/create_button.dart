import 'package:shadcn_flutter/shadcn_flutter.dart';

class CreateButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData? icon;
  const CreateButton({super.key, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      trailing: Icon(icon ?? LucideIcons.circlePlus),
      onPressed: onPressed,
      child: Text('Crear'),
    );
  }
}
