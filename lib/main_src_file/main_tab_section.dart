import 'package:flutter/material.dart';
import 'package:oracle_solutions_project/main_src_file/service_page/service_area.dart';
import '../Constants.dart';
import 'contact_page/contact_area.dart';
import 'expertise_page/expertise_area.dart';
import 'home_page/introduction_area.dart';

class OracleSolutionsPage extends StatefulWidget {
  const OracleSolutionsPage({super.key});

  @override
  OracleSolutionsPageState createState() => OracleSolutionsPageState();
}

class OracleSolutionsPageState extends State<OracleSolutionsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  final GlobalKey _introKey = GlobalKey();
  final GlobalKey _whyChooseUsKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _scrollToSection(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    final sectionKeys = [
      _introKey,
      _servicesKey,
      _whyChooseUsKey,
      _contactKey,
    ];

    final targetContext = sectionKeys[index].currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildSection(GlobalKey key, Widget content) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: content,
    );
  }

  Widget _buildHeader(bool isWeb) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: const Color(0xFFE1E2F6).withOpacity(0.94),
          border: const Border(
              bottom: BorderSide(width: 1, color: Color(0x80EBEBEF)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 230,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/new_logo_withoutbg.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (isWeb)
            TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: ColorTheme.navBarColor,
              unselectedLabelColor: const Color(0xFF020000),
              labelStyle: headingText.copyWith(fontSize: 16),
              unselectedLabelStyle: normalText,
              indicatorColor: ColorTheme.navBarColor,
              dividerHeight: 0,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Home'),
                Tab(text: 'Services'),
                Tab(text: 'Why Choose Us'),
                Tab(text: 'Contact'),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isWeb = MediaQuery.of(context).size.width > 768;
    return Scaffold(
      // Make scaffold fully transparent
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true, // Add this to extend content behind AppBar
      appBar: isWeb
          ? PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: _buildHeader(isWeb),
            )
          : PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE1E2F6).withOpacity(0.94),
                  border: const Border(
                    bottom: BorderSide(width: 1, color: Color(0x80EBEBEF)),
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/new_logo_withoutbg.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.menu),
                          color: ColorTheme.navBarColor,
                          onPressed: () {
                            // Show a drawer or bottom sheet with the tabs
                            Scaffold.of(context).openEndDrawer();
                          },
                        )
                        // For larger screens, show the tab bar
                      ],
                    );
                  },
                ),
              ),
            ),
      endDrawer: Drawer(
        backgroundColor: Colors.transparent,
        width: 180,
        child: Column(
          children: [
            Container(
              width: 180,
              height: 250,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(20)),
                color: Colors.white.withOpacity(0.7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10, right: 20),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close),
                    ),
                  ),
                  Flexible(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        ListTile(
                          title: Text('Home', style: normalText),
                          onTap: () {
                            _tabController.animateTo(0);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('Services', style: normalText),
                          onTap: () {
                            _tabController.animateTo(1);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('Why Choose Us', style: normalText),
                          onTap: () {
                            _tabController.animateTo(2);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: Text('Contact', style: normalText),
                          onTap: () {
                            _tabController.animateTo(3);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(_introKey, const IntroductionSection()),
              _buildSection(_servicesKey, ServiceSection()),
              _buildSection(_whyChooseUsKey, const ECommerceServices()),
              _buildSection(_contactKey, const ContactSection()),
            ],
          ),
        ),
      ),
    );
  }
}
