import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class AddAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: green1,
      title: const Text(
        "ADD TO DO",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: white,
        ),
      ),
    );
  }
}
