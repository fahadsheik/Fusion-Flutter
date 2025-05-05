import 'package:flutter/material.dart';

class GestureSidebar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget child;
  final double sensitivity;
  final bool enableGesture;
  final bool leftEdgeEnabled;
  final bool rightEdgeEnabled;
  final double edgeWidthFactor;

  const GestureSidebar({
    Key? key,
    required this.scaffoldKey,
    required this.child,
    this.sensitivity = 10.0,
    this.enableGesture = true,
    this.leftEdgeEnabled = true,
    this.rightEdgeEnabled = false,
    this.edgeWidthFactor = 1.0, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!enableGesture) {
      return child;
    }
    
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > sensitivity) {
          scaffoldKey.currentState?.openDrawer();
        }
      },
      behavior: HitTestBehavior.translucent, 
      child: child,
    );
  }
}