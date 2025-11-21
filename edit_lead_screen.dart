import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lead_model.dart';
import '../providers/lead_provider.dart';

class EditLeadScreen extends StatefulWidget {
  final LeadModel lead;
  const EditLeadScreen({super.key, required this.lead});
  @override
  State<EditLeadScreen> createState() => _EditLeadScreenState();
}

class _EditLeadScreenState extends State<EditLeadScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _contact;
  late final TextEditingController _notes;
  late String status;

  @override
  void initState() {
    super.initState();
    final l = widget.lead;
    _name = TextEditingController(text: l.name);
    _contact = TextEditingController(text: l.contact);
    _notes = TextEditingController(text: l.notes);
    status = l.status;
  }

  @override
  void dispose() {
    _name.dispose();
    _contact.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final updated = LeadModel(
        id: widget.lead.id,
        name: _name.text.trim(),
        contact: _contact.text.trim(),
        notes: _notes.text.trim(),
        status: status);
    await Provider.of<LeadProvider>(context, listen: false).update(updated);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Lead')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _contact,
                  decoration: const InputDecoration(labelText: 'Contact'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null),
              const SizedBox(height: 12),
              TextFormField(
                  controller: _notes,
                  decoration: const InputDecoration(labelText: 'Notes'),
                  maxLines: 4),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: status,
                items: ['New', 'Contacted', 'Converted', 'Lost']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => status = v!),
                decoration: const InputDecoration(labelText: 'Status'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _save, child: const Text('Save Changes')),
            ],
          ),
        ),
      ),
    );
  }
}
