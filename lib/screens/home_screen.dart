import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chore_provider.dart';
import '../widgets/bubble_widget.dart';
import '../widgets/custom_bottom_bar.dart';
import 'create_chore_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          // Bubbles
          Consumer<ChoreProvider>(
            builder: (context, choreProvider, child) {
              return Stack(
                children: choreProvider.items.map((chore) {
                  return BubbleWidget(
                    key: ValueKey(chore.id),
                    chore: chore,
                    screenSize: screenSize,
                  );
                }).toList(),
              );
            },
          ),
          // Bottom Bar
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomBar(),
          ),
          // Plus Button
          Positioned(
            bottom: 90, // Adjust to position above/on the tab bar
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CreateChoreScreen()),
                  );
                },
                child: Image.asset(
                  'assets/images/plus_button.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
