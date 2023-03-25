import 'package:flutter/material.dart';

class CustomDropDownShowSheet extends StatelessWidget {
  const CustomDropDownShowSheet({
    Key? key,
    this.onClick,
  }) : super(key: key);

  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onClick,
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: const Color(0xFF222529),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(
              Icons.circle,
              size: 31,
            ),
            SizedBox(width: 2),
            Text("ETH"),
            SizedBox(width: 2),
            Icon(
              Icons.arrow_downward_outlined,
              size: 11,
            ),
          ],
        ),
      ),
    );
  }
}
