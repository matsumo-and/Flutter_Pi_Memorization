import 'package:flutter/material.dart';

///Inkwell,Card,Sizedboxを一緒くたにしただけのクラス
class TappableCard extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final double height;
  final EdgeInsets margin;
  final RoundedRectangleBorder border;
  final bool ignoring;

  const TappableCard({
    Key? key,
    required this.child,
    required this.onTap,
    this.height = 80,
    this.margin = const EdgeInsets.all(0),
    this.border = const RoundedRectangleBorder(),
    this.ignoring = true,
  }) : super(key: key);

  ///card background color
  static const Color backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Card(
        color: Colors.transparent,
        shape: border,
        elevation: 0,
        child: InkWell(
          customBorder: border,
          onTap: onTap,
          child: Ink(
            decoration: const BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: IgnorePointer(
              ignoring: ignoring,
              child: SizedBox(
                height: height,
                width: MediaQuery.of(context).size.width,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
