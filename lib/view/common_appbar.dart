import 'package:flutter/material.dart';
import 'package:flutter_pi_memorization/view/setting/setting_page.dart';

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
        onPressed: () => Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
                fullscreenDialog: true,
                builder: ((context) => const SettingPage()))),
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
