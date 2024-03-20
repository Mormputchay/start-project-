import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../color.dart';

class BuilderAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  const BuilderAppBar({
    super.key,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: TColor.primary,
      elevation: 0,
      leading: IconButton(
          onPressed: () {}, icon: SvgPicture.asset("assets/svg/back.svg")),
      actions: actions,
    );
  }

  @override
// TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
