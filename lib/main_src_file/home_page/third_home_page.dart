import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../Constants.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _bottomSlideAnimation;
  late Animation<double> _bottomFadeAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller but don't start it yet
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _bottomSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    ));

    _bottomFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    ));
  }

  late ScrollController _scrollController;

  void _checkPosition() {
    if (!_hasAnimated) {
      final RenderObject? renderObject = context.findRenderObject();
      if (renderObject != null) {
        final RenderBox box = renderObject as RenderBox;
        final position = box.localToGlobal(Offset.zero);

        // Start animation when widget is well within viewport
        if (position.dy < MediaQuery.of(context).size.height * 0.6) {
          _hasAnimated = true;
          _controller.forward();
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_checkPosition);
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction >= 0.25 && !_hasAnimated) {
      _hasAnimated = true;
      _controller.forward(from: 0.0); // Restart the animation
    } else if (info.visibleFraction < 0.05 && _hasAnimated) {
      _hasAnimated = false;
      _controller.reverse(); // Reverse the animation when out of view
    }
  }

  @override
  Widget build(BuildContext context) {
    isWeb(context);
    return VisibilityDetector(
      key: const Key('introduction-section 3'),
      onVisibilityChanged: _handleVisibilityChanged,
      child: Center(
        child: SlideTransition(
          position: _bottomSlideAnimation,
          child: FadeTransition(
            opacity: _bottomFadeAnimation,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/WE-Image/Solutions.jpg",
                  width: screenWidth,
                  height: 500,
                  fit: BoxFit.fill,
                ),
                screenWidth > 500
                    ? Positioned(
                        left: screenWidth * 0.4,
                        child: Container(
                          padding: EdgeInsets.only(top: screenWidth * 0.04),
                          width: screenWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                'Unlock Your E-Commerce Potential with Oracle Solutions',
                                style: pageHeadingText.copyWith(
                                    fontSize: 25,
                                    color: ColorTheme.mainTextColor),
                              ),
                              const SizedBox(height: 20.0),
                              SelectableText(
                                'At Oracle Solutions, we specialize in delivering top-tier e-commerce services designed to help your business succeed in the digital world. With years of experience and a team of skilled professionals, we provide end-to-end solutions that drive growth, increase efficiency, and improve your online sales performance.',
                                style: normalText2,
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    color: ColorTheme.mainTextColor,
                                  ),
                                  child: const Text(
                                    "Read More",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.white.withOpacity(0.4),
                        padding: EdgeInsets.all(20),
                        width: screenWidth * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SelectableText(
                              'Unlock Your E-Commerce Potential with Oracle Solutions',
                              style: pageHeadingText.copyWith(
                                  fontSize: 25,
                                  color: ColorTheme.mainTextColor),
                            ),
                            const SizedBox(height: 20.0),
                            SelectableText(
                              'At Oracle Solutions, we specialize in delivering top-tier e-commerce services designed to help your business succeed in the digital world. With years of experience and a team of skilled professionals, we provide end-to-end solutions that drive growth, increase efficiency, and improve your online sales performance.',
                              style: normalText2,
                            ),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: ColorTheme.mainTextColor,
                                ),
                                child: const Text(
                                  "Read More",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
