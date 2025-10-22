import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final double logoSize = 120;
  final double radius = 150;

  final icons = [
    {'label': 'تماس با ما', 'asset': 'assets/images/contact.png', 'url': 'https://icspi.ir/contact'},
    {'label': 'مجله', 'asset': 'assets/images/magazine.png', 'url': 'https://drive.google.com/drive/folders/1YNIMOvaaApuF0bPwcIYPTqDjInKxaXb3'},
    {'label': 'کانال ایتا', 'asset': 'assets/images/eitaa.png', 'url': 'https://eitaa.com/icspi1'},
    {'label': 'کمک‌های مردمی', 'asset': 'assets/images/donation.png', 'url': ''},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _showDonationDialog(BuildContext context) {
    const String cardNumber = '6037 9981 9827 8037';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C2541),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'کمک‌های مردمی',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'شماره کارت جهت واریز کمک‌های مردمی:',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 12),
            SelectableText(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(const ClipboardData(text: cardNumber));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('شماره کارت کپی شد ✅')),
                );
              },
              icon: const Icon(Icons.copy),
              label: const Text('کپی شماره کارت'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(String label, String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1.0, end: 1.0),
          duration: const Duration(milliseconds: 200),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF283E51), Color(0xFF485563)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 6,
                      offset: Offset(2, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(assetPath, width: 60, height: 60),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B132B),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'ICSPI App',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/logo.png', width: logoSize, height: logoSize),
                  for (int i = 0; i < icons.length; i++)
                    Transform.translate(
                      offset: Offset(
                        radius * cos(2 * pi * i / icons.length + _controller.value * 2 * pi),
                        radius * sin(2 * pi * i / icons.length + _controller.value * 2 * pi),
                      ),
                      child: _buildIcon(
                        icons[i]['label']!,
                        icons[i]['asset']!,
                            () {
                          if (icons[i]['label'] == 'کمک‌های مردمی') {
                            _showDonationDialog(context);
                          } else {
                            _launchUrl(icons[i]['url']!);
                          }
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}