import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final PreferredSizeWidget? bottom;
  const HomeAppBar({Key? key, required this.title, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: title,
      leading: IconButton(
        onPressed: () {
          //TODO implement Menu
        },
        icon: const Icon(Icons.menu),
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    final double bottomPreferedSize =
        bottom == null ? 0 : bottom!.preferredSize.height;
    return Size.fromHeight(kToolbarHeight + bottomPreferedSize);
  }
}
