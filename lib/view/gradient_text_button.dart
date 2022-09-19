import 'package:flutter/material.dart';

class GradientTextButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final bool disabled;
  final Function()? onPressed;

  const GradientTextButton(
      {Key? key,
      required this.title,
      required this.width,
      required this.height,
      this.disabled = false,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: disabled
                ? [
                    const Color.fromRGBO(81, 133, 213, 0.4),
                    const Color.fromRGBO(103, 149, 224, 0.4)
                  ]
                : [
                    const Color.fromRGBO(81, 133, 213, 1),
                    const Color.fromRGBO(103, 149, 224, 1)
                  ]),
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
          )),
          overlayColor: MaterialStateColor.resolveWith(
              (_) => const Color.fromRGBO(71, 123, 203, 1)),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
