import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/client.dart';
import '../services/client_provider.dart';

class MyClientsScreen extends StatefulWidget {
  const MyClientsScreen({super.key});

  @override
  State<MyClientsScreen> createState() => _MyClientsScreenState();
}

class _MyClientsScreenState extends State<MyClientsScreen> {
  String _statusFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final filteredClients = clientProvider.filterByStatus(_statusFilter);
    return Scaffold(
      appBar: AppBar(title: const Text('My Clients')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Filter:', style: TextStyle(color: Colors.white70)),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _statusFilter,
                  dropdownColor: Colors.white,
                  items: const [
                    DropdownMenuItem(value: 'All', child: Text('All', style: TextStyle(color: Colors.black))),
                    DropdownMenuItem(value: 'Pending', child: Text('Pending', style: TextStyle(color: Colors.black))),
                    DropdownMenuItem(value: 'Approved', child: Text('Approved', style: TextStyle(color: Colors.black))),
                  ],
                  onChanged: (v) => setState(() => _statusFilter = v!),
                  style: const TextStyle(color: Colors.black),
                  iconEnabledColor: Color(0xFF660066),
                  underline: Container(height: 2, color: Color(0xFF660066)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredClients.isEmpty
                  ? const Center(
                      child: Text('No clients found.', style: TextStyle(color: Colors.white70)),
                    )
                  : ListView.separated(
                      itemCount: filteredClients.length,
                      separatorBuilder: (_, __) => const Divider(color: Colors.white12),
                      itemBuilder: (context, i) {
                        final client = filteredClients[i];
                        return ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          tileColor: Colors.grey[100],
                          leading: CircleAvatar(
                            backgroundColor: client.status == 'Approved' ? Color(0xFF660066) : Colors.black12,
                            child: Text(client.name[0], style: const TextStyle(color: Colors.white)),
                          ),
                          title: Text(client.name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          subtitle: Text('Illness: ${client.illness}', style: const TextStyle(color: Colors.black87)),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: client.status == 'Approved' ? Color(0xFF660066) : Colors.black12,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              client.status,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
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