import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/client.dart';
import '../services/client_provider.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _illnessController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _gender;
  String _status = 'Pending';
  bool _isLoading = false;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _statuses = ['Pending', 'Approved'];

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // Placeholder for API
    final client = Client(
      name: _nameController.text,
      age: _ageController.text,
      gender: _gender!,
      address: _addressController.text,
      illness: _illnessController.text,
      phone: _phoneController.text,
      status: _status,
    );
    Provider.of<ClientProvider>(context, listen: false).addClient(client);
    setState(() => _isLoading = false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Success', style: TextStyle(color: Color(0xFF660066))),
        content: const Text('Client added successfully!', style: TextStyle(color: Colors.black)),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Add Client')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) => v == null || v.isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Age'),
                validator: (v) => v == null || v.isEmpty ? 'Enter age' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gender,
                items: _genders.map((g) => DropdownMenuItem(value: g, child: Text(g, style: const TextStyle(color: Colors.black)))).toList(),
                decoration: const InputDecoration(labelText: 'Gender'),
                onChanged: (v) => setState(() => _gender = v),
                validator: (v) => v == null ? 'Select gender' : null,
                dropdownColor: Colors.white,
                iconEnabledColor: Color(0xFF660066),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validator: (v) => v == null || v.isEmpty ? 'Enter address' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _illnessController,
                decoration: const InputDecoration(labelText: 'Illness'),
                validator: (v) => v == null || v.isEmpty ? 'Enter illness' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (v) => v == null || v.isEmpty ? 'Enter phone' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                items: _statuses.map((s) => DropdownMenuItem(value: s, child: Text(s, style: const TextStyle(color: Colors.black)))).toList(),
                decoration: const InputDecoration(labelText: 'Status'),
                onChanged: (v) => setState(() => _status = v!),
                dropdownColor: Colors.white,
                iconEnabledColor: Color(0xFF660066),
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