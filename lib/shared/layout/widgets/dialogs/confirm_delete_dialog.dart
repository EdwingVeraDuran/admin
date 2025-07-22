import 'package:shadcn_flutter/shadcn_flutter.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  const ConfirmDeleteDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmar operación'),
      content: Text(
        '¿Esta seguro de eliminar este elemento? Esta acción es irreversible.',
      ),
      actions: [
        OutlineButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        DestructiveButton(onPressed: onConfirm, child: Text('Eliminar')),
      ],
    );
  }
}
