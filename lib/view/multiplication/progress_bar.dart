import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressBar extends ConsumerStatefulWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  ProgressBarState createState() => ProgressBarState();
}

class ProgressBarState extends ConsumerState<ProgressBar>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, value: 0.5);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.watch_later_outlined,
            size: 18,
            color: Color.fromRGBO(81, 133, 213, 1),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 8,
            width: MediaQuery.of(context).size.width - 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                backgroundColor: const Color.fromRGBO(236, 239, 241, 1),
                color: const Color.fromRGBO(81, 133, 213, 1),
                value: controller.value,
              ),
            ),
          ),
          Text(
            '30',
            style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.caption!.color),
          )
        ],
      ),
    );
    ;
  }
}
