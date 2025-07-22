import 'dart:async';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class SearchField extends StatefulWidget {
  final void Function(String) onChanged;
  const SearchField({super.key, required this.onChanged});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  Timer? _debounce;

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onChanged(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 250),
      child: TextField(
        placeholder: Text('Buscar'),
        features: [InputFeature.leading(Icon(LucideIcons.search))],
        onChanged: _onSearchChanged,
      ),
    );
  }
}
