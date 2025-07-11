import 'package:flutter/material.dart';

class OCRPrescriptionScreen extends StatelessWidget {
  const OCRPrescriptionScreen({super.key});

  void _showComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Coming Soon', style: TextStyle(color: Color(0xFF660066))),
        content: const Text('OCR feature coming soon.', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Color(0xFF660066))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR Prescription')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt, size: 64, color: Color(0xFF660066)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showComingSoon(context),
              icon: const Icon(Icons.add_a_photo),
              label: const Text('Scan or Upload Prescription'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
            ),
            const SizedBox(height: 32),
            const Text('Extracted text will appear here.', style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
} 