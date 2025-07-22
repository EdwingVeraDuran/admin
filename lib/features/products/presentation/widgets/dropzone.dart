import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class Dropzone extends StatefulWidget {
  final File? file;
  final bool isEditing;
  final void Function(File) onChanged;
  const Dropzone({
    super.key,
    required this.file,
    required this.onChanged,
    this.isEditing = false,
  });

  @override
  State<Dropzone> createState() => _DropzoneState();
}

class _DropzoneState extends State<Dropzone> {
  bool isFile = false;

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        withData: true,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        widget.onChanged(file);
      }
    } catch (e, stack) {
      debugPrint('Error picking file: $e');
      debugPrint('Stacktrace: $stack');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GhostButton(
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Theme.of(context).radiusLgRadius,
          color: Theme.of(context).colorScheme.border,
          strokeWidth: 2,
          dashPattern: [16, 8],
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 250, maxHeight: 200),
          alignment: Alignment.center,
          child: widget.file != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(widget.file!, height: 150),
                    Gap(8),
                    Text('Click para cambiar imagen.').textSmall.lead,
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.cloudUpload, size: 48),
                    Gap(8),
                    Text(
                      'Click para ${widget.isEditing ? 'actualizar' : 'subir'} imagen.',
                    ).base,
                    Text('Solo se acepta JPG y PNG.').textSmall.lead,
                    Text('Tamaño recomendado: 1024x1024').textSmall.lead,
                  ],
                ),
        ),
      ),
      onPressed: () => pickFile(),
    );
  }
}
