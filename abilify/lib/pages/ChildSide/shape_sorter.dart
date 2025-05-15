import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ShapeType { star, circle, triangle }

class ShapeData {
  final ShapeType type;
  final Color color;
  final double size;
  Offset position;
  bool removed;
  ShapeData({
    required this.type,
    required this.color,
    required this.size,
    required this.position,
    this.removed = false,
  });
}

class ShapeSorter extends StatefulWidget {
  const ShapeSorter({super.key});

  @override
  State<ShapeSorter> createState() => _ShapeSorterState();
}

class _ShapeSorterState extends State<ShapeSorter> with TickerProviderStateMixin {
  final double gameWidth = 300;
  final double gameHeight = 220;
  final int shapeCount = 14;
  final Random random = Random();
  List<ShapeData> shapes = [];
  ShapeType? draggingType;
  int? draggingIndex;
  List<AnimationController?> _controllers = [];

  @override
  void initState() {
    super.initState();
    _generateShapesNoOverlap();
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c?.dispose();
    }
    super.dispose();
  }

  void _generateShapesNoOverlap() {
    shapes = [];
    _controllers = [];
    List<Color> colors = [
      Color(0xFFFFD166), // amber
      Color(0xFF4DC3FF), // blue
      Color(0xFFFF8A47), // orange
      Color(0xFF06D6A0), // green
      Color(0xFFB388FF), // purple
    ];
    List<ShapeType> types = [ShapeType.star, ShapeType.circle, ShapeType.triangle];
    int maxTries = 200;
    for (int i = 0; i < shapeCount; i++) {
      final type = types[random.nextInt(types.length)];
      final color = colors[random.nextInt(colors.length)];
      double size = random.nextDouble() * 24 + 40; // 40-64 px
      Offset pos;
      int tries = 0;
      bool overlaps;
      do {
        overlaps = false;
        final posX = random.nextDouble() * (gameWidth - size);
        final posY = random.nextDouble() * (gameHeight - size);
        pos = Offset(posX, posY);
        for (final s in shapes) {
          if (_shapesOverlap(pos, size, s.position, s.size)) {
            overlaps = true;
            break;
          }
        }
        tries++;
        if (overlaps && tries % 30 == 0 && size > 28) size -= 4; // shrink if stuck
      } while (overlaps && tries < maxTries);
      if (!overlaps) {
        shapes.add(ShapeData(
          type: type,
          color: color,
          size: size,
          position: pos,
        ));
        _controllers.add(null);
      }
    }
  }

  bool _shapesOverlap(Offset a, double sizeA, Offset b, double sizeB) {
    Rect rectA = Rect.fromLTWH(a.dx, a.dy, sizeA + 6, sizeA + 6);
    Rect rectB = Rect.fromLTWH(b.dx, b.dy, sizeB + 6, sizeB + 6);
    return rectA.overlaps(rectB);
  }

  void _onShapeSorted(int index) {
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _controllers[index] = controller;
    controller.forward();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          shapes[index].removed = true;
          _controllers[index]?.dispose();
          _controllers[index] = null;
        });
        if (shapes.every((s) => s.removed)) {
          Future.delayed(const Duration(milliseconds: 400), _showEndDialog);
        }
      }
    });
    setState(() {});
  }

  void _showEndDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            width: 320,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.emoji_events, color: Color(0xFFFFD166), size: 48),
                const SizedBox(height: 12),
                Text(
                  'Great job!',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFD166),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _generateShapesNoOverlap();
                          });
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('Play Again', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4DC3FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).maybePop();
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('Other Games', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header section
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.orange.shade300,
                      Color.fromARGB(255, 251, 239, 215),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.only(top: 16, bottom: 25),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber[600],
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shape Sorter',
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Sort the shapes!',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Shape Sorter',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Game area
                    Center(
                      child: Container(
                        width: gameWidth,
                        height: gameHeight,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          border: Border.all(color: Color(0xFFFFD166), width: 2),
                        ),
                        child: Stack(
                          children: [
                            for (int i = 0; i < shapes.length; i++)
                              if (!shapes[i].removed)
                                AnimatedBuilder(
                                  animation: _controllers[i] ?? AlwaysStoppedAnimation(0),
                                  builder: (context, child) {
                                    final scale = 1.0 - ((_controllers[i]?.value ?? 0) * 1.2);
                                    return Positioned(
                                      left: shapes[i].position.dx,
                                      top: shapes[i].position.dy,
                                      child: Transform.scale(
                                        scale: scale > 0 ? scale : 0,
                                        child: Draggable<int>(
                                          data: i,
                                          feedback: _buildShape(shapes[i], dragging: true),
                                          childWhenDragging: Opacity(
                                            opacity: 0.3,
                                            child: _buildShape(shapes[i]),
                                          ),
                                          onDragStarted: () {
                                            setState(() {
                                              draggingType = shapes[i].type;
                                              draggingIndex = i;
                                            });
                                          },
                                          onDraggableCanceled: (_, __) {
                                            setState(() {
                                              draggingType = null;
                                              draggingIndex = null;
                                            });
                                          },
                                          onDragEnd: (_) {
                                            setState(() {
                                              draggingType = null;
                                              draggingIndex = null;
                                            });
                                          },
                                          child: _buildShape(shapes[i]),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Drop targets
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildDropTarget(ShapeType.triangle),
                        const SizedBox(width: 24),
                        _buildDropTarget(ShapeType.star),
                        const SizedBox(width: 24),
                        _buildDropTarget(ShapeType.circle),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShape(ShapeData shape, {bool dragging = false}) {
    BoxDecoration deco = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      border: Border.all(color: Color(0xFFFFD166), width: 2),
    );
    Widget child;
    switch (shape.type) {
      case ShapeType.star:
        child = Icon(Icons.star, color: shape.color, size: shape.size + (dragging ? 8 : 0));
        break;
      case ShapeType.circle:
        child = Container(
          width: shape.size + (dragging ? 8 : 0),
          height: shape.size + (dragging ? 8 : 0),
          decoration: BoxDecoration(
            color: shape.color,
            shape: BoxShape.circle,
            boxShadow: dragging
                ? [BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2)]
                : [],
          ),
        );
        break;
      case ShapeType.triangle:
        child = CustomPaint(
          size: Size(shape.size + (dragging ? 8 : 0), shape.size + (dragging ? 8 : 0)),
          painter: _TrianglePainter(shape.color),
        );
        break;
    }
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: deco,
      child: child,
    );
  }

  Widget _buildDropTarget(ShapeType type) {
    return DragTarget<int>(
      builder: (context, candidateData, rejectedData) {
        final isActive = draggingType == type && candidateData.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: isActive ? Color(0xFFFFD166).withOpacity(0.7) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: Color(0xFFFFD166), width: 2),
          ),
          child: Center(
            child: _buildTargetShape(type),
          ),
        );
      },
      onWillAcceptWithDetails: (index) => index != null && shapes[index].type == type,
      onAcceptWithDetails: (index) => _onShapeSorted(index),
    );
  }

  Widget _buildTargetShape(ShapeType type) {
    switch (type) {
      case ShapeType.star:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Color(0xFFFFD166), size: 40),
            Text('Star', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black))
          ],
        );
      case ShapeType.circle:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Color(0xFF4DC3FF),
                shape: BoxShape.circle,
              ),
            ),
            Text('Circle', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black))
          ],
        );
      case ShapeType.triangle:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              size: const Size(40, 40),
              painter: _TrianglePainter(Color(0xFF06D6A0)),
            ),
            Text('Triangle', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black))
          ],
        );
    }
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 