import 'package:flutter/foundation.dart';
import '../models/lead_model.dart';
import '../repositories/lead_repository.dart';

class LeadProvider extends ChangeNotifier {
  List<LeadModel> _leads = [];
  final LeadRepository _repo = LeadRepository();

  List<LeadModel> get leads => _leads;

  LeadProvider() {
    loadLeads();
  }

  Future<void> loadLeads() async {
    final data = await _repo.fetchLeads();
    _leads = data;
    notifyListeners();
  }

  Future<void> add(LeadModel lead) async {
    await _repo.addLead(lead);
    await loadLeads();
  }

  Future<void> update(LeadModel lead) async {
    await _repo.updateLead(lead);
    await loadLeads();
  }

  Future<void> delete(int id) async {
    await _repo.deleteLead(id);
    await loadLeads();
  }
}
