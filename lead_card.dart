import 'package:flutter/material.dart';
import '../models/lead_model.dart';

class LeadCard extends StatelessWidget {
  final LeadModel lead;
  final VoidCallback onTap;

  const LeadCard({super.key, required this.lead, required this.onTap});

  Color statusColor(String s) {
    switch (s) {
      case "Contacted":
        return Colors.orange;
      case "Converted":
        return Colors.green;
      case "Lost":
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        title: Text(lead.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(lead.contact),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor(lead.status).withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(lead.status, style: TextStyle(color: statusColor(lead.status), fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
