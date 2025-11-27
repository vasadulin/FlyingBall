import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Adjust height based on image aspect ratio
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            'assets/images/bottom_bar.png',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          // You can add transparent buttons here if you need interactivity later
        ],
      ),
    );
  }
}
