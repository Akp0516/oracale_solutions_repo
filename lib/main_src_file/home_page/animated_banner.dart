import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../Constants.dart';

class AnimatedBanner extends StatefulWidget {
  const AnimatedBanner({super.key});

  @override
  State<AnimatedBanner> createState() => _AnimatedBannerState();
}

class _AnimatedBannerState extends State<AnimatedBanner>
    with TickerProviderStateMixin {
  // Changed from SingleTickerProviderStateMixin
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Initialize pulse animation controller
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true); // Makes it go back and forth continuously

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCirc,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    // Create pulse animation
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1, // Adjust this value to control the size range
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _controller.forward();
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction >= 0.35 && !_hasAnimated) {
      _hasAnimated = true;
      _controller.forward();
    } else if (info.visibleFraction < 0.05 && _hasAnimated) {
      _hasAnimated = false;
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isWeb(context);
    return VisibilityDetector(
      key: const Key('introduction-section 0'),
      onVisibilityChanged: _handleVisibilityChanged,
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            // Banner Image
            Image.asset(
              "assets/images/WE-Image/Banner.jpg",
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.9,
              fit: BoxFit.cover,
            ),
            // Darkening Overlay
            screenWidth > 850
                ? Positioned.fill(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeInAnimation,
                        child: Center(
                          child: ScaleTransition(
                            scale: _pulseAnimation,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Think BIGGER Sell SMARTER",
                                  style: thickStyle.copyWith(
                                    fontSize: 64,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Positioned.fill(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeInAnimation,
                        child: Center(
                          child: ScaleTransition(
                            scale: _pulseAnimation,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              alignment: Alignment.center,
                              child: Text(
                                "Think BIGGER Sell SMARTER",
                                style: thickStyle.copyWith(
                                  fontSize: 54,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        );
      }),
    );
  }
}
