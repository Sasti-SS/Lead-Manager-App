import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lead_model.dart';
import '../providers/lead_provider.dart';
import 'edit_lead_screen.dart';

class LeadDetailScreen extends StatelessWidget {
  final LeadModel lead;
  const LeadDetailScreen({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<LeadProvider>(context, listen: false);

    Future<void> _delete() async {
      final ok = await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Delete lead?'),
          content: const Text('This will remove the lead permanently.'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(c, false),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () => Navigator.pop(c, true),
                child: const Text('Delete')),
          ],
        ),
      );
      if (ok == true) {
        await notifier.delete(lead.id!);
        if (context.mounted) Navigator.pop(context);
      }
    }

    Future<void> _updateStatus(String status) async {
      final updated = LeadModel(
          id: lead.id,
          name: lead.name,
          contact: lead.contact,
          notes: lead.notes,
          status: status);
      await notifier.update(updated);
      if (context.mounted) Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lead Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => EditLeadScreen(lead: lead))),
          ),
          IconButton(icon: const Icon(Icons.delete), onPressed: _delete),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
                title: Text(lead.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))),
            Row(children: [
              const Icon(Icons.contact_mail),
              const SizedBox(width: 8),
              Text(lead.contact)
            ]),
            const SizedBox(height: 12),
            Align(
                alignment: Alignment.centerLeft,
                child: const Text('Notes',
                    style: TextStyle(fontWeight: FontWeight.w600))),
            const SizedBox(height: 6),
            Text(lead.notes.isEmpty ? 'No notes' : lead.notes),
            const SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: const Text('Status',
                    style: TextStyle(fontWeight: FontWeight.w600))),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['New', 'Contacted', 'Converted', 'Lost'].map((s) {
                final selected = s == lead.status;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selected ? null : Colors.grey.shade200,
                    foregroundColor: selected ? Colors.white : Colors.black87,
                  ),
                  onPressed: selected ? null : () => _updateStatus(s),
                  child: Text(s),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
