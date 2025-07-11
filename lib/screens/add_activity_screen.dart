import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/activity.dart';
import '../services/activity_provider.dart';
import '../services/client_provider.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedClient;
  String? _activityType;
  final TextEditingController _notesController = TextEditingController();
  DateTime? _selectedDate;
  bool _isLoading = false;

  final List<String> _activityTypes = [
    'Field Visit', 'Equipment', 'Education', 'Training', 'Financial Assist'
  ];

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
      builder: (context, child) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF660066), // header, selected, etc.
            onPrimary: Colors.white, // text on primary
            surface: Colors.white, // dialog background
            onSurface: Colors.black, // text on surface
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _submit() async {
    if (!_formKey.currentState!.validate() || _selectedDate == null) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // Placeholder for API
    final activity = Activity(
      clientName: _selectedClient!,
      type: _activityType!,
      notes: _notesController.text,
      date: _selectedDate!,
    );
    Provider.of<ActivityProvider>(context, listen: false).addActivity(activity);
    setState(() => _isLoading = false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[100],
        title: const Text('Success', style: TextStyle(color: Color(0xFF660066))),
        content: const Text('Activity added successfully!', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF660066))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final activityProvider = Provider.of<ActivityProvider>(context, listen: false);
    final List<String> clientNames = clientProvider.clients.map((c) => c.name).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Activity')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedClient,
                items: clientNames.map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(color: Colors.black)))).toList(),
                decoration: const InputDecoration(labelText: 'Client'),
                onChanged: (v) => setState(() => _selectedClient = v),
                validator: (v) => v == null ? 'Select client' : null,
                dropdownColor: Colors.white,
                iconEnabledColor: Color(0xFF660066),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _activityType,
                items: _activityTypes.map((a) => DropdownMenuItem(value: a, child: Text(a, style: const TextStyle(color: Colors.black)))).toList(),
                decoration: const InputDecoration(labelText: 'Activity Type'),
                onChanged: (v) => setState(() => _activityType = v),
                validator: (v) => v == null ? 'Select activity type' : null,
                dropdownColor: Colors.white,
                iconEnabledColor: Color(0xFF660066),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes'),
                validator: (v) => v == null || v.isEmpty ? 'Enter notes' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: const Text('Pick Date'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const CircularProgressIndicator(strokeWidth: 2, color: Colors.black)
                      : const Text('Submit', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 