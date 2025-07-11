import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/activity.dart';
import '../services/activity_provider.dart';

class MyActivitiesScreen extends StatefulWidget {
  const MyActivitiesScreen({super.key});

  @override
  State<MyActivitiesScreen> createState() => _MyActivitiesScreenState();
}

class _MyActivitiesScreenState extends State<MyActivitiesScreen> {
  String _typeFilter = 'All';

  final List<String> _activityTypes = [
    'All', 'Field Visit', 'Equipment', 'Education', 'Training', 'Financial Assist'
  ];

  @override
  Widget build(BuildContext context) {
    final activityProvider = Provider.of<ActivityProvider>(context);
    final filteredActivities = activityProvider.filterByType(_typeFilter);
    return Scaffold(
      appBar: AppBar(title: const Text('My Activities')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Filter:', style: TextStyle(color: Colors.black54)),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _typeFilter,
                  dropdownColor: Colors.white,
                  items: _activityTypes.map((t) => DropdownMenuItem(value: t, child: Text(t, style: const TextStyle(color: Colors.black)))).toList(),
                  onChanged: (v) => setState(() => _typeFilter = v!),
                  style: const TextStyle(color: Colors.black),
                  iconEnabledColor: Color(0xFF660066),
                  underline: Container(height: 2, color: Color(0xFF660066)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredActivities.isEmpty
                  ? const Center(
                      child: Text('No activities found.', style: TextStyle(color: Colors.black54)),
                    )
                  : ListView.separated(
                      itemCount: filteredActivities.length,
                      separatorBuilder: (_, __) => const Divider(color: Colors.black12),
                      itemBuilder: (context, i) {
                        final activity = filteredActivities[i];
                        return ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          tileColor: Colors.grey[100],
                          leading: const Icon(Icons.event_note, color: Color(0xFF660066)),
                          title: Text('${activity.type} for ${activity.clientName}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          subtitle: Text('Date: ${activity.date.toLocal().toString().split(' ')[0]}\nNotes: ${activity.notes}', style: const TextStyle(color: Colors.black87)),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
} 