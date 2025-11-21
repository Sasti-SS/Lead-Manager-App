import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lead_model.dart';
import '../providers/lead_provider.dart';

class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});
  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _notes = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _contact.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    final lead = LeadModel(name: _name.text.trim(), contact: _contact.text.trim(), notes: _notes.text.trim());
    await Provider.of<LeadProvider>(context, listen: false).add(lead);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Lead')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _name, decoration: const InputDecoration(labelText: 'Name'), validator: (v) => (v==null||v.trim().isEmpty) ? 'Required' : null),
              const SizedBox(height: 12),
              TextFormField(controller: _contact, decoration: const InputDecoration(labelText: 'Contact (phone/email)'), validator: (v) => (v==null||v.trim().isEmpty) ? 'Required' : null),
              const SizedBox(height: 12),
              TextFormField(controller: _notes, decoration: const InputDecoration(labelText: 'Notes / Description'), maxLines: 3),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
