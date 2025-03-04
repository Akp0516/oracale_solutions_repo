import 'package:flutter/material.dart';

import '../../Constants.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ServiceItem extends StatefulWidget {
  final String title;
  final String icon;
  final int index;
  final bool isVerticalLayout;

  const ServiceItem({
    super.key,
    required this.title,
    required this.icon,
    required this.index,
    this.isVerticalLayout = false,
  });

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Setup rotation animation
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.05).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeInOut,
      ),
    );

    // Setup scale animation
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.15),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.15, end: 1.0),
        weight: 1,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction >= 0.3) {
      _hoverController.repeat(reverse: true);
    } else {
      _hoverController.stop();
    }
  }

  Widget _buildAnimatedIcon(String icon) {
    return VisibilityDetector(
      key: Key('${widget.title}_${widget.index}'),
      onVisibilityChanged: _handleVisibilityChanged,
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child!,
          );
        },
        child: Image.asset(
          icon,
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.height * 0.07,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isWeb(context);
    // Vertical layout for small screens
    if (widget.isVerticalLayout) {
      return (widget.index % 2 != 0)
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 90),
                    _buildAnimatedIcon(widget.icon),
                    const SizedBox(width: 16),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 30,
                      ),
                      height: 2,
                      width: 30,
                      color: const Color(0xFF077B7F).withOpacity(0.3),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: screenWidth * 0.33,
                  child: Text(
                    widget.title,
                    style: normalText.copyWith(color: ColorTheme.mainTextColor),
                    maxLines: 3,
                    // textAlign: TextAlign.center,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Text(
                    widget.title,
                    style: normalText.copyWith(color: ColorTheme.mainTextColor),
                    textAlign: TextAlign.end,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(
                        left: 30,
                      ),
                      height: 2,
                      width: 30,
                      color: const Color(0xFF077B7F).withOpacity(0.3),
                    ),
                    const SizedBox(width: 16),
                    if (widget.icon != '') _buildAnimatedIcon(widget.icon),
                    const SizedBox(width: 50),
                  ],
                ),
              ],
            );
    }

    // Original horizontal layout with alternating positions
    return (widget.index % 2 != 0)
        ? Container(
            margin: const EdgeInsets.only(
              bottom: 60,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildAnimatedIcon(widget.icon),
                    const SizedBox(height: 26),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 30,
                      ),
                      height: 30,
                      width: 2,
                      color: const Color(0xFF077B7F).withOpacity(0.3),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: Text(
                    widget.title,
                    style: normalText.copyWith(color: ColorTheme.mainTextColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: const EdgeInsets.only(
              top: 60,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: Text(
                    widget.title,
                    style: normalText.copyWith(color: ColorTheme.mainTextColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      height: 30,
                      width: 2,
                      color: const Color(0xFF077B7F).withOpacity(0.3),
                    ),
                    const SizedBox(height: 16),
                    if (widget.icon != '') _buildAnimatedIcon(widget.icon),
                  ],
                ),
              ],
            ),
          );
  }
}
