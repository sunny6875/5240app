
import 'package:flutter/material.dart';


class BottomSheetContent extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onSpaces;

  const BottomSheetContent({
    super.key,
    required this.title,
    required this.leading,
    required this.trailing,
    required this.onTap,
    required this.onSpaces,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leading != null) Container(child: leading!),
                const SizedBox(width: 20,),
                if (title != null) title!,
                GestureDetector(
                  onTap: onSpaces,
                  child: const SizedBox(
                    width: 90,
                    child: Text(""),
                  ),
                ),
              ],
            ),

            trailing ?? const Text("    "),
          ],
        ),
      ),
    );
  }
}
