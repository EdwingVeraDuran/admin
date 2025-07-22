import 'package:shadcn_flutter/shadcn_flutter.dart';

class Field extends StatelessWidget {
  final String label;
  final Widget child;
  const Field({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(label).semiBold.small, Gap(4), child],
    );
  }
}
