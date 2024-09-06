import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class CustomAnimationPage extends StatefulWidget {
  const CustomAnimationPage({super.key});

  @override
  State<CustomAnimationPage> createState() => _CustomAnimationPageState();
}

class _CustomAnimationPageState extends State<CustomAnimationPage> {
  double _position = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).customAnimationDemo),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAnimation(offset: _position),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            double lastPoint = MediaQuery.of(context).size.width - 110;
            // Change the position
            _position = _position == 10.0 ? lastPoint : 10.0;
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

class CustomAnimation extends StatefulWidget {
  final double offset;
  CustomAnimation({required this.offset});

  @override
  State<CustomAnimation> createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<CustomAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween<double>(begin: widget.offset, end: widget.offset)
        .animate(_animationController!);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomAnimation oldWidget) {
    if (oldWidget.offset != widget.offset) {
      _animation = Tween<double>(begin: oldWidget.offset, end: widget.offset)
          .animate(_animationController!);
      _animationController?.forward(from: 0.0); // Restart the animation
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return Transform.translate(
            offset: Offset(_animation!.value, 0),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
            ));
      },
      animation: _animation!,
    );
  }
}
