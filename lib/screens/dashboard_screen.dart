import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AngelMed Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.medical_services, color: Color(0xFF660066), size: 36),
                SizedBox(width: 12),
                Text('AngelMed', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
            const SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                children: [
                  _DashboardCard(
                    icon: Icons.person_add_alt_1,
                    label: 'Add Client',
                    onTap: () => Navigator.pushNamed(context, '/clients/add'),
                  ),
                  _DashboardCard(
                    icon: Icons.people,
                    label: 'My Clients',
                    onTap: () => Navigator.pushNamed(context, '/clients/list'),
                  ),
                  _DashboardCard(
                    icon: Icons.add_task,
                    label: 'Add Activity',
                    onTap: () => Navigator.pushNamed(context, '/activities/add'),
                  ),
                  _DashboardCard(
                    icon: Icons.history,
                    label: 'My Activities',
                    onTap: () => Navigator.pushNamed(context, '/activities/list'),
                  ),
                  _DashboardCard(
                    icon: Icons.camera_alt,
                    label: 'OCR Prescription',
                    onTap: () => Navigator.pushNamed(context, '/prescriptions/ocr'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _DashboardCard({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFF660066), width: 2),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF660066).withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Color(0xFF660066)),
              const SizedBox(height: 12),
              Text(label, style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
} 