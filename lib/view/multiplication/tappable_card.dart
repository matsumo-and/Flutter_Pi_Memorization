import 'package:flutter/material.dart';

class TappableCard extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final double height;
  final EdgeInsets margin;
  final RoundedRectangleBorder border;
  final bool ignoring;

  const TappableCard({
    Key? key,
    this.height = 80,
    required this.child,
    required this.onTap,
    this.margin = const EdgeInsets.all(0),
    this.border = const RoundedRectangleBorder(),
    this.ignoring = true,
  }) : super(key: key);

  ///card background color
  static const Color backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IgnorePointer(
        ignoring: ignoring,
        child: Card(
            margin: margin,
            color: backgroundColor,
            shape: border,
            child: SizedBox(
              height: height,
              width: MediaQuery.of(context).size.width,
              child: child,
            )),
      ),
    );
  }
}
