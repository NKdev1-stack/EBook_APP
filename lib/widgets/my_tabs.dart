import 'package:flutter/material.dart';

class AppTab extends StatelessWidget {
  final String title;
  final Color color;
  const AppTab({super.key,required this.title,required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        "$title",
        style: TextStyle(color: Colors.white,fontSize: 17),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: [
            BoxShadow(
                color:
                Colors.grey.withOpacity(0.3),
                blurRadius: 7,
                // First value in offset indicate left/right
                // Second in offset indicate up/down

                offset: Offset(0, 0))
          ]),
    );
  }
}
