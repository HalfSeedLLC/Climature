import 'package:flutter/material.dart';

class GradientContainer extends StatefulWidget {
  const GradientContainer({
    this.width = 20,
    this.height = 20,
    this.borderRadius = 20,
    Key? key,
  }) : super(key: key);

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(GradientContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.width != oldWidget.width ||
        widget.height != oldWidget.height ||
        widget.borderRadius != oldWidget.borderRadius) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0xFF252525),
                Color(0xFF1C1C1C),
                Color(0xFF252525),
                Color(0xFF353535)
              ],
              stops: [
                0.0,
                _animation.value,
                _animation.value + 0.35,
                _animation.value + 0.8,
              ],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
