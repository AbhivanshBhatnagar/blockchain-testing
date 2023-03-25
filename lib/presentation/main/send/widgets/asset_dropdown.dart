import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AssetDropDown extends ConsumerWidget {
  const AssetDropDown({super.key, required this.onTap});

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        width: 163,
        height: 43,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(33),
          color: const Color.fromRGBO(44, 43, 50, 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Icon(
              Icons.circle,
              size: 31,
            ),
            SizedBox(width: 4),
            Text(
              'Ethereum',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Inter',
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1),
            ),
            Spacer(),
            Icon(
              Icons.arrow_downward_outlined,
              size: 11,
            ),
            SizedBox(width: 8)
          ],
        ),
      ),
    );
  }
}
