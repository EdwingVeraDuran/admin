import 'package:flutter/widgets.dart';

class HiddenScroll extends StatelessWidget {
  final Widget child;
  const HiddenScroll({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(padding: EdgeInsets.all(24), child: child),
    );
  }
}
