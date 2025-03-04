import 'package:flutter/material.dart';
import 'package:oracle_solutions_project/Constants.dart';
import 'package:oracle_solutions_project/main_src_file/home_page/second_home_page.dart';
import 'package:oracle_solutions_project/main_src_file/home_page/third_home_page.dart';

import 'animated_banner.dart';

class IntroductionSection extends StatefulWidget {
  const IntroductionSection({super.key});

  @override
  State<IntroductionSection> createState() => _IntroductionSectionState();
}

class _IntroductionSectionState extends State<IntroductionSection>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    isWeb(context);
    return const Center(
      child: Column(
        children: [AnimatedBanner(), SecondHomePage(), ThirdPage()],
      ),
    );
  }
}
