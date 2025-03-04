import 'package:flutter/material.dart';

import '../../Constants.dart';
import 'expertise_item.dart';

class ECommerceServices extends StatefulWidget {
  const ECommerceServices({super.key});

  @override
  State<ECommerceServices> createState() => _ECommerceServicesState();
}

BuildContext? ctx;

class _ECommerceServicesState extends State<ECommerceServices>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _lineController;
  late List<Animation<double>> _itemAnimations;

  final services = [
    {
      'title': 'Cost-Effective\nStrategies',
      'icon': 'assets/images/WE-Image/Cost.png',
    },
    {
      'title': 'Reliable & Responsive\nSupport',
      'icon': 'assets/images/WE-Image/Support.png',
    },
    if (screenWidth < 800 || screenWidth > 995)
      {
        'title': 'E-Commerce',
        'icon': '',
      },
    {
      'title': 'Proactive E-Commerce\nSolutions',
      'icon': 'assets/images/WE-Image/Solution.png',
    },
    {
      'title': 'Product Listing\nManagement',
      'icon': 'assets/images/WE-Image/Mannagment.png',
    },
  ];

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _lineController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _itemAnimations = List.generate(
      services.length,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            index * 0.2,
            0.2 + index * 0.2,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );

    _fadeController.forward();
    _lineController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _lineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isWeb(context);
    ctx = context;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 800;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Why Choose us',
                  style: pageHeadingText,
                  textAlign: TextAlign.center,
                ),
                SelectableText(
                  'Oracle Solutions for Your E-Commerce Needs?',
                  style: normalText2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (isSmallScreen)
                  // Vertical layout for small screens
                  CustomPaint(
                    painter: ZigZagPainter(),
                    foregroundPainter:
                        LinePainter(_lineController, isVertical: true),
                    child: Column(
                      children: List.generate(
                        services.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: FadeTransition(
                            opacity: _itemAnimations[index],
                            child: ServiceItem(
                              icon: services[index]['icon']!,
                              title: services[index]['title']!,
                              index: index,
                              isVerticalLayout: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  // Original horizontal layout for larger screens
                  CustomPaint(
                    size: Size.infinite,
                    painter: ZigZagPainter(),
                    foregroundPainter:
                        LinePainter(_lineController, isVertical: false),
                    child: Wrap(
                      spacing: MediaQuery.of(context).size.width * 0.06,
                      runSpacing: 100,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        services.length,
                        (index) => FadeTransition(
                          opacity: _itemAnimations[index],
                          child: ServiceItem(
                            icon: services[index]['icon']!,
                            title: services[index]['title']!,
                            index: index,
                            isVerticalLayout: false,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LinePainter extends CustomPainter {
  final Animation<double> animation;
  final bool isVertical;

  LinePainter(this.animation, {this.isVertical = false})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF077B7F).withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    if (isVertical) {
      // Vertical line for small screens
      path.moveTo(size.width / 2, 0);
      path.lineTo(size.width / 2, size.height);
    } else {
      // Horizontal line for large screens
      path.moveTo(-200, size.height / 2);
      path.lineTo(MediaQuery.of(ctx!).size.width, size.height / 2);
    }

    // Animate the line drawing
    final progress = animation.value;
    final metrics = path.computeMetrics().first;
    final animatedPath = Path();

    for (var i = 0.0; i < progress; i += 0.01) {
      final point = metrics.getTangentForOffset(i * metrics.length)!;
      if (i == 0) {
        animatedPath.moveTo(point.position.dx, point.position.dy);
      } else {
        animatedPath.lineTo(point.position.dx, point.position.dy);
      }
    }

    canvas.drawPath(animatedPath, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}

class ZigZagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey.withOpacity(0.15)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path = Path();
    double step = 200; // Size of the zigzag wave
    double yOffset = size.height / 2; // Position the zigzag at the center

    path.moveTo(0, yOffset);

    for (double x = 0; x < MediaQuery.of(ctx!).size.width; x += step) {
      if ((x / step).toInt().isEven) {
        path.lineTo(x + step / 2, yOffset - step);
      } else {
        path.lineTo(x + step / 2, yOffset + step);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
