import 'package:flutter/material.dart';

class MainPageHeader extends StatelessWidget {
  const MainPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 57,
            height: 57,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/new_logo.jpeg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Oracle Solutions',
            style: TextStyle(fontFamily: "Norican", fontSize: 28),
          ),
        ],
      ),
    );
  }
}
