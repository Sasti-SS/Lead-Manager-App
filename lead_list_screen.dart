import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lead_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/lead_card.dart';
import 'add_lead_screen.dart';
import 'lead_detail_screen.dart';
import '../models/lead_model.dart';

class LeadListScreen extends StatefulWidget {
  const LeadListScreen({super.key});
  @override
  State<LeadListScreen> createState() => _LeadListScreenState();
}

class _LeadListScreenState extends State<LeadListScreen> {
  String filter = "All";
  String searchQuery = "";





  @override
  Widget build(BuildContext context) {
    final leads = Provider.of<LeadProvider>(context).leads;
    final notifier = Provider.of<LeadProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    List<LeadModel> filtered = leads;
    if (filter != "All") {
      filtered = filtered.where((e) => e.status == filter).toList();
    }
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
              (e) => e.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lead Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => notifier.loadLeads(),
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            tooltip: 'Toggle Theme',
            onPressed: () {
              themeProvider.toggle();
            },
          ),
          PopupMenuButton<String>(
            onSelected: (v) => setState(() => filter = v),
            itemBuilder: (context) => [
              "All",
              "New",
              "Contacted",
              "Converted",
              "Lost"
            ].map((e) => PopupMenuItem(value: e, child: Text(e))).toList(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AddLeadScreen())),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search by name'),
              onChanged: (v) => setState(() => searchQuery = v),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text('No leads found.',
                        style: Theme.of(context).textTheme.bodyLarge))
                : RefreshIndicator(
                    onRefresh: () async => await notifier.loadLeads(),
                    child: ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final lead = filtered[index];
                        return LeadCard(
                          lead: lead,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      LeadDetailScreen(lead: lead))),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
