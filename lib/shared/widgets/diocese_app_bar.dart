import 'package:flutter/material.dart';

class DioceseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  const DioceseAppBar({super.key, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            'assets/images/diocese_logo.png',
            width: 38,
            height: 38,
            fit: BoxFit.contain,
          ),

          const SizedBox(width: 10),

          const Expanded(
            child: Text(
              'Nyimbo za Dini',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
