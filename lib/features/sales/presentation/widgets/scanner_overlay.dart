import 'package:flutter/material.dart';

/// A self-contained scanner overlay widget that manages its own animation.
/// The animation only runs when [isScanning] is true, saving battery.
class ScannerOverlay extends StatefulWidget {
  final bool isScanning;

  const ScannerOverlay({super.key, required this.isScanning});

  @override
  State<ScannerOverlay> createState() => _ScannerOverlayState();
}

class _ScannerOverlayState extends State<ScannerOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.1, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start animation if initially scanning
    if (widget.isScanning) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant ScannerOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle animation state changes
    if (widget.isScanning != oldWidget.isScanning) {
      if (widget.isScanning) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.stop();
        _animationController.reset();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isScanning) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _ScannerOverlayPainter(_animation.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  final double scanAnimationValue;

  _ScannerOverlayPainter(this.scanAnimationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Yellow corner paint
    final cornerPaint = Paint()
      ..color = const Color(0xFFFFEB3B)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // Laser line paint
    final laserPaint = Paint()
      ..color = const Color(0xFFFF5722).withOpacity(0.8)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final boxW = size.width * 0.7;
    final boxH = boxW * 0.6;
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final rect = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: boxW,
      height: boxH,
    );

    const cornerLen = 20.0;

    // Draw Corner Markers
    // Top-Left
    canvas.drawLine(
      rect.topLeft,
      rect.topLeft + const Offset(0, cornerLen),
      cornerPaint,
    );
    canvas.drawLine(
      rect.topLeft,
      rect.topLeft + const Offset(cornerLen, 0),
      cornerPaint,
    );
    // Top-Right
    canvas.drawLine(
      rect.topRight,
      rect.topRight + const Offset(0, cornerLen),
      cornerPaint,
    );
    canvas.drawLine(
      rect.topRight,
      rect.topRight - const Offset(cornerLen, 0),
      cornerPaint,
    );
    // Bottom-Left
    canvas.drawLine(
      rect.bottomLeft,
      rect.bottomLeft - const Offset(0, cornerLen),
      cornerPaint,
    );
    canvas.drawLine(
      rect.bottomLeft,
      rect.bottomLeft + const Offset(cornerLen, 0),
      cornerPaint,
    );
    // Bottom-Right
    canvas.drawLine(
      rect.bottomRight,
      rect.bottomRight - const Offset(0, cornerLen),
      cornerPaint,
    );
    canvas.drawLine(
      rect.bottomRight,
      rect.bottomRight - const Offset(cornerLen, 0),
      cornerPaint,
    );

    // Draw Animated Laser Line
    final laserY = rect.top + (rect.height * scanAnimationValue);
    canvas.drawLine(
      Offset(rect.left + 10, laserY),
      Offset(rect.right - 10, laserY),
      laserPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScannerOverlayPainter oldDelegate) {
    return oldDelegate.scanAnimationValue != scanAnimationValue;
  }
}
