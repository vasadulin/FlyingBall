import 'package:flutter/material.dart';
import 'dart:math';
import '../models/chore_item.dart';

class BubbleWidget extends StatefulWidget {
  final ChoreItem chore;
  final Size screenSize;

  const BubbleWidget({super.key, required this.chore, required this.screenSize});

  @override
  State<BubbleWidget> createState() => _BubbleWidgetState();
}

class _BubbleWidgetState extends State<BubbleWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _startX;
  late double _startY;
  late double _amplitude;
  late double _frequency;
  late double _phase;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    // Randomize initial position and movement parameters
    final random = Random();
    // Keep within screen bounds (roughly)
    _startX = random.nextDouble() * (widget.screenSize.width - 100);
    
    // Calculate safe vertical range
    // Top padding: 100 (avoid status bar/top)
    // Bottom padding: 250 (avoid Plus button and Bottom Bar)
    // Bubble height: 100
    final double topPadding = 100;
    final double bottomPadding = 250;
    final double bubbleHeight = 100;
    final double availableHeight = widget.screenSize.height - topPadding - bottomPadding - bubbleHeight;
    
    _startY = random.nextDouble() * (availableHeight > 0 ? availableHeight : 0) + topPadding;
    
    _amplitude = random.nextDouble() * 20 + 10; // 10-30 pixels
    _frequency = random.nextDouble() * 2 + 1; // 1-3 Hz equivalent
    _phase = random.nextDouble() * 2 * pi;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Simple floating motion: Sine wave on Y axis, slight drift on X
        final yOffset = sin(_controller.value * 2 * pi * _frequency + _phase) * _amplitude;
        final xOffset = cos(_controller.value * 2 * pi * _frequency * 0.5 + _phase) * (_amplitude * 0.5);

        return Positioned(
          left: _startX + xOffset,
          top: _startY + yOffset,
          child: child!,
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // Removed colored background and shadow to use image
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Bubble Background Image
            Image.asset(
              'assets/images/bubble_bg.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            // Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.chore.type.icon, color: const Color.fromARGB(221, 8, 24, 162), size: 32),
                const SizedBox(height: 4),
                Text(
                  widget.chore.title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
