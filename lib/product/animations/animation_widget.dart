import 'package:flutter/material.dart';

class AnimatedTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const AnimatedTextButton({required this.text, required this.onPressed});

  @override
  _AnimatedTextButtonState createState() => _AnimatedTextButtonState();
}

class _AnimatedTextButtonState extends State<AnimatedTextButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '➤',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(width: 8),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final double progress = _animation.value;
              final int textLength = widget.text.length;
              final String animatedText = widget.text.substring(
                0,
                (progress * textLength).floor(),
              );
              return Text(
                animatedText,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              );
            },
          ),
        ],
      ),
    );
  }
}
