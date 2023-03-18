import 'package:flutter/material.dart';

class MovingContainer extends StatefulWidget {
  @override
  _MovingContainerState createState() => _MovingContainerState();
}

class _MovingContainerState extends State<MovingContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: false);
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  List<Widget> _buildTiles() {
    return List.generate(
        4,
        (index) => Container(
              height: 100,
              width: 70,
              color: Colors.blue,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: _offsetAnimation.value * MediaQuery.of(context).size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _buildTiles(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
