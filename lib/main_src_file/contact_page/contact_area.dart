import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants.dart';
import 'contact_form.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isContactHovered = false;
  bool _isSubscribeHovered = false;

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard: $text')),
    );
  }

  Widget contactInfo(
      BuildContext context, IconData icon, String label, String info) {
    return InkWell(
      onTap: () => copyToClipboard(context, info),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blueAccent, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: normalText.copyWith(fontSize: 16),
                  children: [
                    TextSpan(
                      text: '$label ',
                      style: normalText.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: info),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContactFormPopup(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Contact Form',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(
            opacity:
                Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
            child: Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const ContactFormPopup(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SelectableText(
          title,
          style: normalText.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        SelectableText(
          content,
          style: simpleText.copyWith(
            fontSize: 14,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    isWeb(context);
    return Container(
      constraints: const BoxConstraints(minHeight: 300),
      child: Stack(
        children: [
          Image.asset(
            "assets/images/WE-Image/Footer.jpg",
            fit: BoxFit.fill,
            height: screenWidth > 649 ? 300 : 450,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectableText(
                      "Do you want to get update what's upcoming?",
                      style: headingText.copyWith(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Contact Us Button with Animation
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 16),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) =>
                                setState(() => _isContactHovered = true),
                            onExit: (_) =>
                                setState(() => _isContactHovered = false),
                            child: ElevatedButton(
                              onPressed: () {
                                _showContactFormPopup(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    ColorTheme.subscribeButtonColor,
                                elevation: _isContactHovered ? 8 : 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: AnimatedPadding(
                                duration: Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                    horizontal: _isContactHovered ? 15 : 10,
                                    vertical: 16),
                                child: Text(
                                  "Contact Us",
                                  style: normalText2.copyWith(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Subscribe Now Button with Animation
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) =>
                                setState(() => _isSubscribeHovered = true),
                            onExit: (_) =>
                                setState(() => _isSubscribeHovered = false),
                            child: ElevatedButton(
                              onPressed: () async {
                                final Uri uri = Uri.parse(
                                    "https://www.instagram.com/oraclesolutions2?igsh=MXMyYjJ3anJqdWI1MQ==");
                                try {
                                  if (!await launchUrl(
                                    uri,
                                    mode: LaunchMode.platformDefault,
                                    webOnlyWindowName: '_blank',
                                  )) {
                                    print('Could not launch $uri');
                                  }
                                } catch (e) {
                                  print('Error launching URL: $e');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    ColorTheme.subscribeButtonColor,
                                elevation: _isSubscribeHovered ? 8 : 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: AnimatedPadding(
                                duration: Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                    horizontal: _isSubscribeHovered ? 10 : 5,
                                    vertical: 16),
                                child: Text(
                                  "Subscribe Now",
                                  style: normalText2.copyWith(
                                      fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                screenWidth > 649
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoSection(
                              "EMAIL ADDRESS", "oraclesolutions02@gmail.com"),
                          _buildInfoSection(
                            "ADDRESS",
                            "604, Scheme 134, Vijay Nagar,\n Indore, Madhya Pradesh 452010, India",
                          ),
                          _buildInfoSection(
                              "CONTACT NUMBER", "+91 93408 00455"),
                        ],
                      )
                    : Column(
                        children: [
                          _buildInfoSection(
                              "EMAIL ADDRESS", "oraclesolutions02@gmail.com"),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: _buildInfoSection(
                              "ADDRESS",
                              "604, Scheme 134, Vijay Nagar,\n Indore, Madhya Pradesh 452010, India",
                            ),
                          ),
                          _buildInfoSection(
                              "CONTACT NUMBER", "+91 93408 00455"),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
