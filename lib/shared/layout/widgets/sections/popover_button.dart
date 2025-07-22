import 'package:shadcn_flutter/shadcn_flutter.dart';

class PopoverButton extends StatelessWidget {
  final IconData? icon;
  final String placeholder;
  final void Function(String) onSubmitted;
  const PopoverButton({
    super.key,
    this.icon,
    required this.placeholder,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      trailing: Icon(icon ?? LucideIcons.circlePlus),
      onPressed: () => showPopover(
        context: context,
        alignment: Alignment.topCenter,
        offset: Offset(0, 8),
        builder: (context) => ModalContainer(
          child: SizedBox(
            width: 200,
            child: TextField(
              placeholder: Text(placeholder),
              onSubmitted: (value) {
                closeOverlay(context);
                onSubmitted(value);
              },
            ),
          ),
        ),
      ),
      child: Text('Crear'),
    );
  }
}
