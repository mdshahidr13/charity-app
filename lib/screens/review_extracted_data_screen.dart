import 'package:flutter/material.dart';

class ReviewExtractedDataScreen extends StatefulWidget {
  const ReviewExtractedDataScreen({super.key});

  @override
  State<ReviewExtractedDataScreen> createState() => _ReviewExtractedDataScreenState();
}

class _ReviewExtractedDataScreenState extends State<ReviewExtractedDataScreen> {
  final List<Map<String, dynamic>> _medicines = [
    {'name': 'Paracetamol', 'dosage': '500mg', 'quantity': 10},
    {'name': 'Dolo 650', 'dosage': '650mg', 'quantity': 5},
  ];

  void _confirm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('Success', style: TextStyle(color: Colors.tealAccent)),
        content: const Text('Medicines confirmed and uploaded!', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK', style: TextStyle(color: Colors.tealAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Extracted Data')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Review Medicines:', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: _medicines.length,
                separatorBuilder: (_, __) => const Divider(color: Colors.white12),
                itemBuilder: (context, i) {
                  final med = _medicines[i];
                  return Card(
                    color: Colors.grey[100],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            initialValue: med['name'],
                            decoration: const InputDecoration(labelText: 'Medicine Name'),
                            style: const TextStyle(color: Colors.black),
                            onChanged: (v) => setState(() => med['name'] = v),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue: med['dosage'],
                            decoration: const InputDecoration(labelText: 'Dosage'),
                            style: const TextStyle(color: Colors.black),
                            onChanged: (v) => setState(() => med['dosage'] = v),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue: med['quantity'].toString(),
                            decoration: const InputDecoration(labelText: 'Quantity'),
                            style: const TextStyle(color: Colors.black),
                            keyboardType: TextInputType.number,
                            onChanged: (v) => setState(() => med['quantity'] = int.tryParse(v) ?? 0),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _confirm,
                child: const Text('Confirm & Upload', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 