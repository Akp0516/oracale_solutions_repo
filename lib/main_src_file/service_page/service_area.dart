import 'package:flutter/material.dart';
import 'package:oracle_solutions_project/Constants.dart';
import 'package:oracle_solutions_project/main_src_file/service_page/service_card.dart';

class ServiceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    isWeb(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 60),
      child: Column(
        children: [
          SelectableText(
            "Our Services",
            style: pageHeadingText,
          ),
          SelectableText(
            'Oracle Solutions - Empowering Sellers, Driving Success',
            style: normalText2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 14,
          ),
          ShrinkingList(),
          // const Divider(),
        ],
      ),
    );
  }
}

class ShrinkingList extends StatelessWidget {
  final List<ServiceItem> services = [
    ServiceItem(
      title: "Ecommerce Account Management",
      description:
          "At Oracle Solutions, we provide comprehensive Ecommerce Account Management services designed to help you grow and succeed across multiple online marketplaces. Our team of experts handles every aspect of your seller account, from listing optimization to inventory management, ensuring your business operates seamlessly.",
      icon: "assets/images/WE-Image/Accoubnt.png",
    ),
    ServiceItem(
      title: "Custom Development Solutions",
      description:
          "At Oracle Solutions, we provide comprehensive Ecommerce Account Management services designed to help you grow and succeed across multiple online marketplaces. Our team of experts handles every aspect of your seller account, from listing optimization to inventory management, ensuring your business operates seamlessly.",
      icon: "assets/images/WE-Image/Custom.png",
    ),
    ServiceItem(
      title: "E-Commerce Platform Setup",
      description:
          "Whether you're launching a new online store or migrating from an existing platform, we ensure a smooth and efficient setup that aligns with your business goals.market trends, we craft strategies that enhance your brand's visibility, increase conversion rates, and drive long-term growth.",
      icon: "assets/images/WE-Image/Setup.png",
    ),
    ServiceItem(
      title: "Social Marketing Services",
      description:
          "Social Media Marketing Services. Social Media Marketing (SMM) is a powerful strategy that leverages social media platforms to connect with your target audience, build brand awareness, and Drive Engagement & Sales.From Content Creation and Curation to Community Management, Daily Posting, Des Stories, Images and Paid Advertising.",
      icon: "assets/images/WE-Image/Services.png",
    ),
    ServiceItem(
      title: "Professional Website Design",
      description:
          "Get a professionally designed website for your business, brand, or personal use. We specialize in creating modern, responsive, and SEO-optimized websites that help you connect with your audience and grow your brand."
          "\nUser-Friendly & Responsive Design"
          "\nFast Loading Speed, Secure & Scalable"
          "\nSEO-Optimized for Google Ranking"
          "\nModern & 24/7 Customer Support",
      icon: "assets/images/WE-Image/Setup.png",
    ),
    ServiceItem(
      title: "Custom Web & app Development",
      description:
          "We build all types of websites based on your specific needs - from business websites and e-commerce stores to blogs, portfolios, news portals, and custom web applications."
          "\nBusiness Websites"
          "\nE-commerce Websites"
          "\nPortfolio Websites"
          "\nNews Portals & Custom Web Applications",
      icon: "assets/images/WE-Image/Accoubnt.png",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool shouldShrink = constraints.maxWidth < 600;
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 30.0, // Space between widgets
            runSpacing: 25.0, // Space between rows
            children: List.generate(6, (index) {
              double scale = shouldShrink ? 0.5 : 1.0;
              return Transform.scale(
                scale: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: index % 2 == 0 ? 0 : 20),
                  child: SizedBox(
                    width: 300,
                    height: 400,
                    child: ServiceCard(service: services[index]),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

class ServiceItem {
  final String title;
  final String description;
  final String icon;
  final List<String>? features;

  ServiceItem({
    required this.title,
    required this.description,
    required this.icon,
    this.features,
  });
}
