import '../db/db_helper.dart';
import '../models/lead_model.dart';

class LeadRepository {
  final DBHelper _db = DBHelper();

  Future<List<LeadModel>> fetchLeads() => _db.getLeads();
  Future<int> addLead(LeadModel lead) => _db.insertLead(lead);
  Future<int> updateLead(LeadModel lead) => _db.updateLead(lead);
  Future<int> deleteLead(int id) => _db.deleteLead(id);
}
