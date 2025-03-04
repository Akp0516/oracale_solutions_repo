import 'package:flutter/material.dart';
import 'package:oracle_solutions_project/main_src_file/service_page/service_area.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../Constants.dart';

class ServiceCard extends StatefulWidget {
  final ServiceItem service;
  const ServiceCard({super.key, required this.service});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _iconRotateAnimation;

  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
    ));

    _iconRotateAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (!_hasAnimated) {
      _controller.forward();
      // _hasAnimated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    isWeb(context);
    return VisibilityDetector(
      key: Key(widget.service.title),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction > 0.3 && !_hasAnimated) {
          _startAnimation();
          _hasAnimated = true;
        } else if (info.visibleFraction < 0.05 && _hasAnimated) {
          _hasAnimated = false;
          _controller.reverse(); // Reverse the animation when out of view
        }
      },
      child: MouseRegion(
        onEnter: (_) {
          if (_hasAnimated) {
            _controller.reverse();
            _controller.forward();
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeInAnimation,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: ColorTheme.serviceCardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.rotate(
                          angle: _iconRotateAnimation.value * 2 * 3.14159,
                          child: Image.asset(
                            widget.service.icon,
                            height: 60,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SelectableText(
                          widget.service.title,
                          textAlign: TextAlign.center,
                          style: headingText.copyWith(
                              color: ColorTheme.mainTextColor),
                        ),
                        const SizedBox(height: 20),
                        SelectableText(
                          widget.service.description,
                          textAlign: TextAlign.center,
                          style: headingText.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
