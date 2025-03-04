import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../Constants.dart';

class SecondHomePage extends StatefulWidget {
  const SecondHomePage({super.key});

  @override
  State<SecondHomePage> createState() => _SecondHomePageState();
}

class _SecondHomePageState extends State<SecondHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideTextAnimation;
  late Animation<Offset> _slideImageAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Top section animations
    _slideTextAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideImageAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
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
    // Only start animation when widget is mostly visible (80%)
    if (info.visibleFraction >= 0.25 && !_hasAnimated) {
      _hasAnimated = true;
      _controller.forward();
    } else if (info.visibleFraction < 0.05 && _hasAnimated) {
      _hasAnimated = false;
      _controller.reverse(); // Reverse the animation when out of view
    }
  }

  @override
  Widget build(BuildContext context) {
    isWeb(context);
    return LayoutBuilder(builder: (context, Constrants) {
      return VisibilityDetector(
        key: const Key('introduction-section 1'),
        onVisibilityChanged: _handleVisibilityChanged,
        child: screenWidth > 750
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _slideTextAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                top: screenWidth * 0.04, left: 16, right: 20),
                            width: screenWidth * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SelectableText(
                                  'Are You Tapping into the Full Potential of E-Commerce Marketplaces?',
                                  style: pageHeadingText.copyWith(
                                      fontSize: 25,
                                      color: ColorTheme.mainTextColor),
                                ),
                                const SizedBox(height: 30.0),
                                SelectableText(
                                  'Did you know that only 30-40% of sellers are fully leveraging the potential of e-commerce through marketplaces like Amazon, Flipkart, Meesho, Ajio, and more?At Oracle Solutions, we bring extensive experience working with clients across the USA, UK, Dubai, and India. Our team is skilled in understanding diverse customer demographics and is well-versed in the complex buying behaviors of consumers globally, helping you unlock your business full potential.',
                                  style: normalText2,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _slideImageAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: screenWidth * 0.35 - 16,
                        height: screenHeight * 0.64,
                        margin: EdgeInsets.only(
                            right: screenWidth * 0.01, top: 50, bottom: 50),
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/WE-Image/Abouy.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SlideTransition(
                    position: _slideImageAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.9,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/WE-Image/Abouy.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _slideTextAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        color: Colors.white.withOpacity(0.4),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        width: screenWidth * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SelectableText(
                              'Are You Tapping into the Full Potential of E-Commerce Marketplaces?',
                              style: pageHeadingText.copyWith(
                                  fontSize: 25,
                                  color: ColorTheme.mainTextColor),
                            ),
                            const SizedBox(height: 30.0),
                            SelectableText(
                              'Did you know that only 30-40% of sellers are fully leveraging the potential of e-commerce through marketplaces like Amazon, Flipkart, Meesho, Ajio, and more?At Oracle Solutions, we bring extensive experience working with clients across the USA, UK, Dubai, and India. Our team is skilled in understanding diverse customer demographics and is well-versed in the complex buying behaviors of consumers globally, helping you unlock your business full potential.',
                              style: normalText2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
